import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'models/user.dart';
import 'constants.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfilePage(),
    );
  }
}

class ProfilePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

class CategoryPageState extends State<ProfilePage> {
  List<Users> userdetail = [];
  bool editMode = false;
  TextEditingController usernameController = TextEditingController();
  TextEditingController useremailController = TextEditingController();
  TextEditingController userpasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getuserdetail();
  }

  Future<void> getuserdetail() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userid') ?? '';

    var res = await http.post(
      Uri.parse(BASE_URL + "user_action/get_user_details.php"),
      body: {
        'userID': userId,
      },
    );

    if (res.statusCode == 200) {
      var data = jsonDecode(res.body);
      setState(() {
        userdetail = [Users.fromJson(data)];
        usernameController.text = userdetail[0].username ?? '';
        useremailController.text = userdetail[0].useremail ?? '';
        userpasswordController.text = userdetail[0].userpassword ?? '';
        print(userdetail);
      });
    } else {
      throw Exception('Failed to load Users');
    }
  }

  Future<void> updateUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userid') ?? '';

    var res = await http.post(
      Uri.parse(BASE_URL + "user_action/update_user_detail.php"),
      body: {
        'userID': userId,
        'username': usernameController.text,
        'useremail': useremailController.text,
        'userpassword': userpasswordController.text,
      },
    );

    if (res.statusCode == 200) {
      print(res.body);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(res.body),
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Profile()),
      );

    } else {
      throw Exception('Failed to update user details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: userdetail.isEmpty
          ? Center(child: CircularProgressIndicator())
          : editMode //on of the useful mode
          ? ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'Username',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: useremailController,
            decoration: InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: userpasswordController,
            obscureText: true,
            decoration: InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              updateUserDetails();
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: Text('Save'),
          ),
        ],
      )

          : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                height: 600,
                width: 370,
                child: ListView(
                  padding: EdgeInsets.all(16.0),
                  children: [
                    SizedBox(height: 20),
                    CircleAvatar(
                      radius: 70,
                      child: Icon(Icons.account_circle, size: 120),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Username',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${userdetail[0].username ?? 'Unknown'}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            Text(
                              '${userdetail[0].useremail ?? 'Unknown Email'}',
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Password',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 5),
                            ObscuredText(userdetail[0].userpassword ?? 'Unknown Password'),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          editMode = true;
                        });
                      },
                      child: Text('Edit Details'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ObscuredText extends StatelessWidget {
  final String text;

  ObscuredText(this.text);

  @override
  Widget build(BuildContext context) {
    // Create a string with the same length as the password filled with asterisks
    String obscuredText = '*' * (text.length);

    return Text(
      '$obscuredText',
      style: TextStyle(fontSize: 18),
    );
  }
}
