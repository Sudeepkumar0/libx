import 'package:flutter/material.dart';
import 'package:libx/user_login.dart';
import 'user_signup.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user_signup(),
    );
  }
}

void main() {
  runApp(MyApp());
}
