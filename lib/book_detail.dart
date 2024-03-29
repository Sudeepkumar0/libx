import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libx/pdf_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';
import 'models/book.dart';

class BookDetail extends StatefulWidget {
  final Book book;

  BookDetail({required this.book});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<BookDetail> {
  // late bool isBookSaved;

  @override
  void initState() {
    super.initState();
    // isBookSaved = widget.isBookSaved;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book Details'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 200,
                  height: 270,
                  child: Image.network(
                    widget.book.imageUrl ?? 'https://example.com/default_image.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 16.0),
              Text(
                'Name: ${widget.book.name}',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.0),
              Text('Author: ${widget.book.author}'),
              SizedBox(height: 8.0),
              Text('Description: ${widget.book.description}'),
              SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () {
              _launchPDFViewer(context, widget.book.name, widget.book.pdfUrl);
            },
            child: Icon(Icons.book),
          ),
          SizedBox(height: 16.0),
          FloatingActionButton(
            onPressed: () {
              _saveBook(context, widget.book.id);
            },
            child: Icon(Icons.save),
          ),
        ],
      ),
    );
  }

  void _launchPDFViewer(BuildContext context, String? name, String? pdfUrl) {
    if (pdfUrl != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewerScreen(bookname: name!, pdfUrl: pdfUrl),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Book Document is not available'),
      ));
    }
  }

  void _saveBook(BuildContext context, String? bookId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userid') ?? '';

    var response = await http.post(Uri.parse(BASE_URL + "user_action/saved_books.php"), body: {
      'bookId': bookId,
      'userId': userId,
    });

     print(response.body);
      if (response.statusCode == 200) {
        // setState(() {
        //   isBookSaved = true;
        // });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(response.body),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to save book'),
          ),
        );
      }
    }
  }
