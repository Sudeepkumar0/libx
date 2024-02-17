import 'package:flutter/material.dart';

class userhome extends StatefulWidget {
  const userhome({Key? key});
  @override
  State<userhome> createState() => _userhomeState();
}

class _userhomeState extends State<userhome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottom navigation  bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3), // Shadow color with opacity
              spreadRadius: 1, // Spread radius
              blurRadius: 4, // Blur radius
              offset: Offset(0, -2), // Offset of the shadow (0 is for no offset in x-axis, -2 is for moving the shadow upwards)
            ),
          ],
        ),
        height: 118,
        child: BottomNavigationBar(
          backgroundColor: Colors.deepPurple,
          items: [
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Icon(Icons.home),
              ),
              label: 'Home',
              backgroundColor: Colors.deepPurple,
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Icon(Icons.book_rounded,),
              ),
              label: 'MyBooks',
            ),
            BottomNavigationBarItem(
              icon: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: Icon(Icons.category),
              ),
              label: 'Category',
            ),
          ],
          selectedItemColor: Colors.black,
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),




      //App Top navigation bar
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70),
        child: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Text(
                  'Logo',
                  textAlign: TextAlign.right,
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 190),
                  child: Icon(
                    Icons.search,
                    color: Colors.white,
                    size: 35,
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
