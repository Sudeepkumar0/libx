import 'package:flutter/material.dart';
import 'package:libx/Category.dart';
import 'top_books.dart';
import 'user_login.dart';
import 'userhome.dart';
import 'user_signup.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: UserHome(),
    );
  }
}

void main() {
  runApp(MyApp());
}
