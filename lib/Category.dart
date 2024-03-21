import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libx/category_page.dart';

class Category extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CategoryPage(),
    );
  }
}

class CategoryPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CategoryPageState();
}

class CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            categoryItem(context, 'Kannada', 'assets/kannada.jpeg', 'Kannada'),
            categoryItem(context, 'Hindi', 'assets/hindi.jpeg', 'Hindi'),
            categoryItem(
                context, 'Maliyalam', 'assets/maliyalam.jpeg', 'Maliyalam'),
            categoryItem(context, 'Tamil', 'assets/tamil.jpg', 'Tamil'),
            categoryItem(context, 'Telugu', 'assets/telugu.jpg', 'Telugu'),
            categoryItem(context, 'English', 'assets/english.jpg', 'English'),
            // Add more categories as needed
          ],
        ),
      ),
    );
  }

  Widget categoryItem(BuildContext context, String categoryName,
      String imagePath, String language) {
    double screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    double imageHeight = screenHeight /
        7.7; // Divide by the number of categories

    return InkWell(
      onTap: () {
       navigateToCategoryDetail(context, language);
      },
      child: Padding(
        padding: const EdgeInsets.all(0),
        child: ColorFiltered(
          colorFilter: ColorFilter.mode(
            Colors.white54.withOpacity(0.9),
            BlendMode.multiply,
          ),
          child: Stack(
            children: [
              Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: imageHeight,
                child: Image.asset(imagePath, fit: BoxFit.cover),
              ),
              Center(
                child: Text(
                  categoryName,
                  style: GoogleFonts.righteous(
                    fontSize: 50,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void navigateToCategoryDetail(BuildContext context, String language) {
    Navigator.push(
      context,
      MaterialPageRoute(
        // builder: (context) => BooksPage(language: language),
        builder: (context) => BookPage(language: language),
      ),
    );
  }
}
