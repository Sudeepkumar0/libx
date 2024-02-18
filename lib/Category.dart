import 'package:flutter/material.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryPage(),
    );
  }
}

class  CategoryPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CategoryPageState();

}

class CategoryPageState  extends State<CategoryPage>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Center(
       child: Text(
         'CategoryPage',
       ),
     ),
   );
  }
}
