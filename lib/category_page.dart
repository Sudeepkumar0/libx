import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'constants.dart';

class BookPage extends StatefulWidget {
  late final String language;

  BookPage({required this.language});
  @override
  State<BookPage> createState() => _BookPageState();
}

class _BookPageState extends State<BookPage> {
  @override
  void initState() {
    super.initState();
    fetchBooks(language);
  }
  Widget build(BuildContext context) {
    return Scaffold(

    );
  }

  Future<void> fetchBooks(String language) async {
    String url = BASE_URL + "user_action/category_page.php";
    var response = await http.post(
      Uri.parse(url),
      body: {
        'language': language,
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> responseData = jsonDecode(response.body);
      // Process the response data here
    } else {
      throw Exception('Failed to load books');
    }
  }

}

