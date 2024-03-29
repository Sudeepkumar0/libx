import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libx/pdf_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'constants.dart';
import 'models/book.dart';

class MyBooks extends StatefulWidget {

  @override
  State<MyBooks> createState() => _MyBooksState();
}

class _MyBooksState extends State<MyBooks> {
  late List<Book> _savedBooks = [];

  @override
  void initState() {
    super.initState();
    _getSavedBooks();
  }

  Future<void> _getSavedBooks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userid') ?? '';

    var response = await http.post(Uri.parse(BASE_URL + "user_action/view_saved_books.php"), body: {
      'userId': userId,
    });

    if (response.statusCode == 200) {
      var data = json.decode(response.body) as List<dynamic>;
      setState(() {
        _savedBooks = data.map((item) => Book.fromJson(item)).toList();
        print(_savedBooks);
      });
    } else {
      throw Exception('Failed to load saved books');
    }
  }

  Future<void> _removeBook(String bookId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userId = prefs.getString('userid') ?? '';

    var response = await http.post(Uri.parse(BASE_URL + "user_action/remove_saved_book.php"), body: {
      'userId': userId,
      'bookId': bookId,
    });

    if (response.statusCode == 200) {
      setState(() {
        print(response.body);
        _savedBooks.removeWhere((book) => book.id == bookId);
      });
    } else {
      throw Exception('Failed to remove book');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Books'),
      ),
      body: _savedBooks == null
          ? Center(child: CircularProgressIndicator())
          : _savedBooks.isEmpty
          ? Center(child: Text('No saved books'))
          : ListView.builder(
        itemCount: _savedBooks.length,
        itemBuilder: (context, index) {
          String imageUrl = _savedBooks[index].imageUrl ?? '';
          String title = _savedBooks[index].name ?? 'Unknown Title';
          String author = _savedBooks[index].author ?? 'Unknown Author';

          return ListTile(
            leading: imageUrl.isNotEmpty ? Image.network(imageUrl) : Container(),
            title: Text(title),
            subtitle: Text(author),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // IconButton(
                //   icon: Icon(Icons.read_more),
                //   onPressed: () {
                //     // Navigate to the read screen
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) => ReadBookScreen(book: _savedBooks[index]),
                //       ),
                //     );
                //   },
                // ),
                TextButton(
                  onPressed: () {
                    // Navigate to the read screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReadBookScreen(book: _savedBooks[index]),
                      ),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.deepPurpleAccent),
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                    padding: MaterialStateProperty.all(EdgeInsets.all(10.0)),
                    side: MaterialStateProperty.all(BorderSide(color: Colors.deepPurpleAccent, width: 1.0)),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(17.0),
                    )),
                  ),
                  child: Text('Open Book'),
                ),


                IconButton(
                  icon: Icon(Icons.delete, color: Colors.redAccent, size: 30),
                  onPressed: () {
                    _removeBook(_savedBooks[index].id!); // Pass the book id to remove
                  }
                ),
              ],
            ),
          );
        },
      ),

    );
  }
}


class ReadBookScreen extends StatefulWidget {
  final Book book;

  ReadBookScreen({required this.book});

  @override
  _BookDetailState createState() => _BookDetailState();
}

class _BookDetailState extends State<ReadBookScreen> {
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

}
