import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'login.dart';

Future<void> logout(BuildContext context) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('token');
  prefs.remove('username');
  prefs.setBool('isLoggedIn', false);

  Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => const Login()),
  );
}