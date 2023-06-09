import 'package:flutter/material.dart';

class GPACalculatorScreen extends StatefulWidget {
  const GPACalculatorScreen({Key? key}) : super(key: key);

  @override
  State<GPACalculatorScreen> createState() => _GPACalculatorScreenState();
}

class _GPACalculatorScreenState extends State<GPACalculatorScreen> {
  bool isNumeric(String s) {
    // ignore: unnecessary_null_comparison
    if (s == null) {
      return false;
    }
    return double.tryParse(s) != null;
  }

  final TextEditingController _gradeController = TextEditingController();
  final TextEditingController _creditController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  // final List<Map<String, dynamic>> _grades = [
  //   {'grade': 'A+', 'min': 98, 'max': 100},
  //   {'grade': 'A', 'min': 93, 'max': 97},
  //   {'grade': 'A-', 'min': 90, 'max': 92},
  //   {'grade': 'B+', 'min': 88, 'max': 89},
  //   {'grade': 'B', 'min': 83, 'max': 87},
  //   {'grade': 'B-', 'min': 80, 'max': 82},
  //   {'grade': 'C+', 'min': 78, 'max': 79},
  //   {'grade': 'C', 'min': 73, 'max': 77},
  //   {'grade': 'C-', 'min': 70, 'max': 72},
  //   {'grade': 'D+', 'min': 68, 'max': 69},
  //   {'grade': 'D', 'min': 63, 'max': 67},
  //   {'grade': 'D-', 'min': 60, 'max': 62},
  //   {'grade': 'F', 'min': 0, 'max': 59},
  // ];

  void _calculateGPA() {
    if (_formKey.currentState!.validate()) {
      print("yay");
    }
  }

  @override
  void dispose() {
    super.dispose();
    _gradeController.dispose();
    _creditController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("GPA Calculator")),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Form(
                  key: _formKey,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextFormField(
                          autocorrect: false,
                          controller: _gradeController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Grade',
                            hintText: 'Enter your grade',
                            border: OutlineInputBorder(),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your grade';
                            } else if (!isNumeric(value)) {
                              return "Please enter a valid grade";
                            }
                            return null;
                          },
                        )
                      ]),
                ),
                const SizedBox(height: 30),
                SizedBox(
                    height: 50,
                    width: 200,
                    child: ElevatedButton.icon(
                      icon: const Icon(
                        Icons.text_increase,
                        size: 20.0,
                      ),
                      label: const Text(
                        'Calculate GPA',
                        textAlign: TextAlign.center,
                      ),
                      onPressed: _calculateGPA,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                      ),
                    ))
                // TextField(
                //   controller: _gradeController,
                //   decoration: const InputDecoration(
                //     labelText: 'Grade',
                //   ),
                // ),
                // TextField(
                //   controller: _creditController,
                //   decoration: const InputDecoration(
                //     labelText: 'Credit',
                //   ),
                //   keyboardType: TextInputType.number,
                // ),
              ],
            ),
          ),
        ));
  }
}
