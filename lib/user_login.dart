import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libx/userhome.dart';

import 'constants.dart';

class user_login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Login(),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();

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
                    labelText: "Email",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Your Email",
                  ),
                  controller: emailcontroller,
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
                    labelText: "Password",
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                    hintText: "Enter Your Password",
                  ),
                  obscureText: true,
                  controller: passwordcontroller,
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
                    foregroundColor: Colors.white, backgroundColor: Colors.deepPurpleAccent,
                  ),
                  onPressed: (){
                    if(validate()){
                      authenticateuser();
                    }
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
      ),
    );
  }

  bool validate() {
    if (emailcontroller.text.isEmpty || !emailcontroller.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid email address"),
        ),
      );
      return false;
    }

    if (passwordcontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter the Password"),
        ),
      );
      return false;
    }
    return true;
  }
  Future<void> authenticateuser() async {
    String url = BASE_URL + "user_action/user_login.php";
    final res = await http.post(Uri.parse(url), body: {
      "email": emailcontroller.text,
      "password": passwordcontroller.text,
    });

    if (res.statusCode == 200) {
      if (res.body != "failure") {
        Navigator.push(
            // context, MaterialPageRoute(builder: (context) => UserHome(userID: res.body)));
            context, MaterialPageRoute(builder: (context) => UserHome()));
      }
      else{
        ScaffoldMessenger.of(context)
            .showSnackBar(new SnackBar(content: Text("Invalid Credentials")));
      }
    }
  }
}
