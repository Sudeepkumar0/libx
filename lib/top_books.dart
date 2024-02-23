import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'constants.dart';

class Book {
  final int ? id;
  final String name;
  final String author;
  final String description;
  final String imageUrl;

  Book({required this.id, required this.name, required this.author, required this.description, required this.imageUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: int.parse(json['id']),
      name: json['bookname'],
      author: json['bookauthor'],
      description: json['bookdescription'],
      imageUrl: BASE_URL + json['bookimage'],
    );
  }
}

class BookList extends StatefulWidget {
  @override
  _BookListState createState() => _BookListState();
}

class _BookListState extends State<BookList> {
  late Future<List<Book>> futureBooks;

  @override
  void initState() {
    super.initState();
    futureBooks = fetchBooks();
  }

  Future<List<Book>> fetchBooks() async {
    String url = BASE_URL + "user_action/top_books.php";
    final response = await http.get(Uri.parse(url));

    if (response.body.isEmpty) {
      throw Exception('Empty response');
    }

    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = [];
      for (var json in jsonResponse) {
        books.add(Book.fromJson(json));
      }
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Book>>(
      future: futureBooks,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          List<Book> books = snapshot.data!;
          return ListView.builder(
            itemCount: books.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Container(
                  width: 56.0,
                  height: 60,// Set the width to the desired size
                  child: Image.network(books[index].imageUrl),
                ),
                title: Text(books[index].name),
                subtitle: Text(books[index].author),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookDetail(book: books[index]),
                    ),
                  );
                },
              );

            },
          );
        }
      },
    );
  }
}

class BookDetail extends StatelessWidget {
  final Book book;

  BookDetail({required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(book.imageUrl),
            SizedBox(height: 16.0),
            Text(
              'Name: ${book.name}',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8.0),
            Text('Author: ${book.author}'),
            SizedBox(height: 8.0),
            Text('Description: ${book.description}'),
          ],
        ),
      ),
    );
  }
}

