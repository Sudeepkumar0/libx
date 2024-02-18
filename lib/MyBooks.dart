import 'package:flutter/material.dart';

class MyBooks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: bookPage(),
    );
  }
}

class  bookPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CategoryPageState();

}

class CategoryPageState  extends State<bookPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'Mybooks',
        ),
      ),
    );
  }
}
