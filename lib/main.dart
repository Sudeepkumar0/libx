import 'package:flutter/material.dart';
import 'user_login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: user_login(),
    );
  }
}

void main() {
  runApp(MyApp());
}
