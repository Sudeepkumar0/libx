import 'package:flutter/material.dart';
import 'Category.dart';
import 'MyBooks.dart';
import 'Profile.dart';

// Define a placeholder HomeScreen widget
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

    );

  }
}

class UserHome extends StatefulWidget {
  const UserHome({Key? key});

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  int _selectedIndex = 0;
  late List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      HomeScreen(),
      Category(),
      MyBooks(),
      Profile(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        backgroundColor: Colors.grey,
        child: Center(
          child: ListTile(
            title: Text('My title'),

          ),
        ),

      ),


      appBar: AppBar(
        iconTheme:IconThemeData(color: Colors.white) ,
        backgroundColor:Colors.deepPurple,
        leading: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: 200,
                height: 200,
                child: Image.asset('assets/logo.png'),

              ),
            ),
          ],
        ),
      ),


      //Bottom navigation

      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.deepPurple,
          labelTextStyle: MaterialStateProperty.all(TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          )),
        ),
        child: NavigationBar(
          selectedIndex: _selectedIndex,
          height: 100,
          backgroundColor: Colors.white,
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.home, size: 30),
              selectedIcon: Icon(Icons.home, size: 30, color: Colors.white),
              label: 'Home',
            ),
            NavigationDestination(
              icon: Icon(Icons.category, size: 30),
              selectedIcon: Icon(Icons.category, size: 30, color: Colors.white),
              label: 'Category',
            ),
            NavigationDestination(
              icon: Icon(Icons.book_rounded, size: 30),
              selectedIcon: Icon(Icons.book_rounded, size: 30, color: Colors.white),
              label: 'MyBooks',
            ),
            NavigationDestination(
              icon: Icon(Icons.person, size: 30),
              selectedIcon: Icon(Icons.person, size: 30, color: Colors.white),
              label: 'Profile',
            ),
          ],
          onDestinationSelected: (int index) {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
      body: _screens[_selectedIndex],
    );
  }
}
