import 'package:flutter/material.dart';

class user_signup extends StatefulWidget {
  const user_signup({Key? key}) : super(key: key);
  @override
  _UserSignupState createState() => _UserSignupState();
}

class _UserSignupState extends State<user_signup> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Signup(),
    );
  }
}

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
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
                    child: Image.asset('assets/education.png'),
                  ),
                ),
              ),
              //img closed here
              //---------------------------------------------------------
              // Register Text
              Container(
                child: Text(
                  'Registration',
                  style: TextStyle(
                    color: Colors.deepPurpleAccent.withOpacity(0.9),
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),

              SizedBox(
                height: 20,
              ),
              //text closed here

              //---------------------------------------------------------
              //Text field user name

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
              //closed Text field user name
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
                        color: Colors.deepPurpleAccent,
                        width: 2,
                      ),
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

              //---------------------------------------------------------
              //Text field password

              Container(
                width: 300,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 2,
                      ),
                    ),
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Your Password",
                  ),
                  obscureText: true,
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //---------------------------------------------------------
              //Text field Re enter pass

              Container(
                width: 300,
                height: 50,
                child: TextField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                      borderSide: BorderSide(
                        color: Colors.deepPurpleAccent,
                        width: 2,
                      ),
                    ),
                    labelText: "Re_Enter_Your_Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Your Password",
                  ),
                  obscureText: true,
                ),
              ),

              SizedBox(
                height: 20,
              ),

              //---------------------------------------------------------
              // register btn

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
                  child: Text('Register',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
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

              SizedBox(
                height: 25,
              ),

              //---------------------------------------------------------
              InkWell(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: Text(
                          'Already have an account?',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                      Container(
                        child: InkWell(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.deepPurple,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
