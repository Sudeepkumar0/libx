import 'package:flutter/material.dart';

class user_login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
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
                'Login',
                style: TextStyle(
                    color: Colors.deepPurpleAccent.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: 40),
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
                    borderSide: BorderSide(
                        color: Colors.deepPurpleAccent, width: 2),
                  ),
                  labelText: "Email",
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  hintText: "Enter Your Email",
                ),
              ),
            ),
            // close Text field Email

            SizedBox(
              height: 10,
            ),

            //forgot password
           Container(
             child: TextButton(
               onPressed: (){

               },
               child: Text('Forgot Password?'),
             ),
           ),

            //login btn

            Container(
              width: 190,
              height: 45,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.deepPurpleAccent,
                  onPrimary: Colors.white,
                ),
                onPressed: (){

                },
                child: Text('Login',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
              ),
              decoration:BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.deepPurple.withOpacity(0.2),
                    blurRadius: 10,
                    offset: Offset(0,3),
                  ),
                ]

              ) ,
            ),




          ],
        ),
      ),
    );
  }
}
