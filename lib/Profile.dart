import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class  ProfilePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => CategoryPageState();

}

class CategoryPageState  extends State<ProfilePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          'profile',
        ),
      ),
    );
  }
}
