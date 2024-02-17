import 'package:flutter/material.dart';
import 'package:libx/user_login.dart';
import 'package:libx/userhome.dart';
import 'user_signup.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: userhome(),
    );
  }
}

void main() {
  runApp(MyApp());
}
