import 'package:flutter/material.dart';

class user_login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: login(),

    );
  }
}

class login extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: Form(child: Column(
         mainAxisAlignment: MainAxisAlignment.start,
         children: [
     //Image
     Padding(
     padding: const EdgeInsets.only(top: 90),
       child: Center(
         child: Container(
           width: 200,
           height: 180,
           child: Image.asset('assets/login_img.png'),
         ),
       ),
     ),
       //img closed here
       //---------------------------------------------------------
       // Register Text
       Container(
         child: Text(
           'Login',style: TextStyle(
             color: Colors.deepPurpleAccent.withOpacity(0.9),
             fontWeight: FontWeight.bold,
             fontSize: 40
         ),
         ),
       ),


       SizedBox(
         height: 20,
       ),
       //text closed here

       //---------------------------------------------------------

       //Text field   user name

       Container(
         width: 300,
         height: 50,
         child: TextField(
           decoration: InputDecoration(
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(5),

             ),
             labelText: "User_Name",
             floatingLabelBehavior: FloatingLabelBehavior.always,
             hintText: "Enter Your Name",
           ),
         ),
       ),
       //closed Text field   user name
       SizedBox(
         height: 20,
       ),

       //---------------------------------------------------------
       //Text field Email

       Container(
         width: 300,
         height: 50,
         child: TextField(
           decoration: InputDecoration(
             border: OutlineInputBorder(
               borderRadius: BorderRadius.circular(5),
               borderSide: BorderSide(color: Colors.deepPurpleAccent,width: 2),

             ),
             labelText: "Email",
             floatingLabelBehavior: FloatingLabelBehavior.always,
             hintText: "Enter Your Email",
           ),
         ),
       ),
       // close Text field Email


       SizedBox(
         height: 20,
       ),


           //forgot password

           Container(
             child: Text(
               'Forgot'
             ),

           ),





     ]
   ),
    ),
   );
  }

}