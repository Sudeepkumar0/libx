import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libx/constants.dart';
import 'package:libx/user_login.dart';

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
  final usernamecontroller = TextEditingController();
  final emailcontroller = TextEditingController();
  final passwordcontroller = TextEditingController();
  final confirmpasswordcontroller = TextEditingController();

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
                  controller: usernamecontroller,
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
                  controller: emailcontroller,
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
              // if (emailcontroller.text.isEmpty ||
              //     !emailcontroller.text.contains('@'))
              // // close Text field Email

              SizedBox(
                height: 20,
              ),

              //---------------------------------------------------------
              //Text field password
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  controller: passwordcontroller,
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
              // if (passwordcontroller.text.isEmpty ||
              //     passwordcontroller.text.length < 6)
              //   Text(
              //     'Please enter a password with at least 6 characters',
              //     style: TextStyle(color: Colors.red),
              //   ),

              SizedBox(
                height: 20,
              ),

              //---------------------------------------------------------
              //Text field Re enter pass
              Container(
                width: 300,
                height: 50,
                child: TextField(
                  controller: confirmpasswordcontroller,
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
                  onPressed: () {
                    if (validate()) {
                      // ScaffoldMessenger.of(context).showSnackBar(
                      // SnackBar(content: Text("Success")));
                      upload();
                    }
                  },
                  child: Text(
                    'Register',
                    style:
                    TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.deepPurple.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
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
                          onTap: () => {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => user_login())),
                          },
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

  bool validate() {
    if (usernamecontroller.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a username"),
        ),
      );
      return false;
    }

    if (emailcontroller.text.isEmpty || !emailcontroller.text.contains('@')) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a valid email address"),
        ),
      );
      return false;
    }

    if (passwordcontroller.text.isEmpty || passwordcontroller.text.length < 6) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please enter a password with at least 6 characters"),
        ),
      );
      return false;
    }

    if (confirmpasswordcontroller.text != passwordcontroller.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return false;
    }

    return true;
  }

  Future<void> upload() async {
    String url = BASE_URL+"user_action/user_registration.php";
    var response = await http.post(Uri.parse(url), body: {
      'name': usernamecontroller.text,
      'email': emailcontroller.text,
      'password': passwordcontroller.text,
    });

    if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) => user_login()));
    } else {
      // Display error message in a SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to connect to server'),
        ),
      );
    }
  }
}
