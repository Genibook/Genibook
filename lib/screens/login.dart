import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:genibook/api/handler.dart';
import 'package:genibook/cache/objects/objects.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/icons/custom_icons_icons.dart';
import 'package:genibook/routes/navigator.dart';
import 'package:genibook/extensions/virtualkeyboard.dart';
import 'package:genibook/models/secret.dart';
import 'package:genibook/widgets/shakey.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _passwordVisible = false;

  final _shakeKey = GlobalKey<ShakeWidgetState>();

  String? _selectedSchool;

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _shakeKey.currentState!.dispose();
  }

  void _login() async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String pass = _passwordController.text;
      String highSchool = _selectedSchool ?? "";
      String userSelector = "1";
      String mp = "MP1";

      Secret aSecret = Secret(
          username: email,
          password: pass,
          userSelector: userSelector,
          mp: mp,
          highSchool: highSchool);

      if (kDebugMode) {
        print("[DEBUG] _login() under screen LOGIN: ");
        print(json.encode(aSecret.toJson()));
      }

      bool valid = await ApiHandler.login(aSecret);
      if (valid) {
        await StoreObjects.storeSecret(aSecret);
        await StoreObjects.readSecret();
        //print(json.encode(aSecret.toJson()));
        // ignore: use_build_context_synchronously
        ApiNavigator.pushToLoadingPage(context, 0);
      } else {
        _shakeKey.currentState?.shake();
      }

      // Perform login logic here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
          const Text(
            Constants.appName,
            style: TextStyle(
              fontSize: 40,
              letterSpacing: 2,
              fontWeight: FontWeight.bold,
            ),
          ),
          context.virtualKeyboardIsOpen
              ? const SizedBox.shrink()
              : Image.asset(
                  'assets/education.png',
                  height: 200,
                  width: 200,
                ),
          Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    //width: 300,
                    child: ButtonTheme(
                        // alignedDropdown: true,
                        child: SizedBox(
                      child: DropdownButtonFormField<String>(
                        isExpanded: true,
                        value: _selectedSchool,
                        items: Constants.schools
                            .map((school) => DropdownMenuItem(
                                  value: school,
                                  child: Text(
                                    school,
                                    textAlign: TextAlign.center,
                                  ),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            _selectedSchool = value ?? "";
                          });
                        },
                        decoration: const InputDecoration(
                          labelText: 'School',
                          hintText: 'Select your school',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please select your school';
                          }
                          return null;
                        },
                      ),
                    )),
                  ),
                ),
                context.virtualKeyboardIsOpen
                    ? const SizedBox(height: 10.0)
                    : const SizedBox(height: 16.0),
                SizedBox(
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      hintText: 'Enter your email',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                ),
                context.virtualKeyboardIsOpen
                    ? const SizedBox(height: 10.0)
                    : const SizedBox(height: 16.0),
                SizedBox(
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        labelText: 'Password',
                        hintText: 'Enter your password',
                        border: const OutlineInputBorder(),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Theme.of(context).primaryColorDark,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        )),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                  ),
                ),
                context.virtualKeyboardIsOpen
                    ? const SizedBox(height: 10.0)
                    : const SizedBox(height: 16.0),
                Center(
                  child: ShakeWidget(
                      key: _shakeKey,
                      // 5. configure the animation parameters
                      shakeCount: 3,
                      shakeOffset: 10,
                      shakeDuration: const Duration(milliseconds: 400),
                      child: SizedBox(
                          height: 50,
                          width: 200,
                          child: ElevatedButton.icon(
                            icon: const Icon(
                              CustomIcons.binoculars,
                              size: 20.0,
                            ),
                            label: const Text(
                              'View your Genesis',
                              textAlign: TextAlign.center,
                            ),
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                          ))),
                ),
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}
