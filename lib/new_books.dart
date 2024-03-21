import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'book_detail.dart';
import 'constants.dart';
import 'models/book.dart';

class newbooks extends StatefulWidget {
  @override
  State<newbooks> createState() => newbooksState();
}

class newbooksState extends State<newbooks> {
  late Future<List<Book>> futureBooks;
  @override
  void initState() {
    super.initState();
    futureBooks = fetchBooks();
  }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'New Books',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            FutureBuilder<List<Book>>(
              future: futureBooks,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    return SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: snapshot.data!.map((book) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BookDetail(book: book),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 120,
                                    height: 150,
                                    child: Image.network(
                                      book.imageUrl ?? 'https://example.com/default_image.jpg',
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    truncateWords(book.name ?? 'Unknown', 3), // Limit to 3 words
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    'by ${book.author ?? 'Unknown'}',
                                    style: TextStyle(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    );

                  }
                }
                return Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      );
    }

  String truncateWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    return words.take(maxWords).join(' ');
  }

  Future<List<Book>> fetchBooks() async {
    String url = BASE_URL + "user_action/new_books.php";
    var response = await http.get(Uri.parse(url));
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = jsonResponse.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }
}

//
// Future<List<Book>> fetchBooks() async {
//   String url = BASE_URL + "user_action/new_books.php";
//   var response = await http.get(Uri.parse(url));
//   print(response.body);
//   if (response.statusCode == 200) {
//     final List<dynamic> jsonResponse = jsonDecode(response.body);
//     List<Book> books = jsonResponse.map((json) {
//       // Replace `\/` with `/` in the image path
//       String imagePath = json['bookimage'].replaceAll('\\/', '/');
//       json['bookimage'] = imagePath;
//       return Book.fromJson(json);
//     }).toList();
//     return books;
//   } else {
//     throw Exception('Failed to load books: ${response.statusCode}');
//   }
// }
