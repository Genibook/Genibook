import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:genibook/constants.dart';
import 'package:genibook/screens/login.dart';
import 'package:http/http.dart' as http;

class ApiNavigator extends Navigator {
  const ApiNavigator({super.key});

  Future<void> loadData() async {
    final response = await http.get(Uri.parse('https://example.com/data.json'));
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  void pushToLogin<T extends Object>(BuildContext context) {
    Navigator.of(context).push<void>(
      MaterialPageRoute<void>(
        builder: (BuildContext context) => LoginPage(),
      ),
    );
  }
}
