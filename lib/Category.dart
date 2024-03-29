import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'book_detail.dart';
import 'constants.dart';
import 'models/book.dart';

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

// Book category page starts from here

class BookPage extends StatelessWidget {
  final String language;

  BookPage({required this.language});

  @override
  Widget build(BuildContext context) {
    final String poetry = "poetry"; // Set your poetry text here
    final String history = "history";
    final String story = "story";
    final String spiritual = "spiritual";
    final String novels = "novels";

    return Scaffold(
      appBar: AppBar(
        title: Text('Books in $language'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 280,
              child: Poetry(language: language, poetry: poetry),
            ),
            Container(
              height: 280,
              child: History(language: language, history: history),
            ),
            Container(
              height: 280,
              child: Story(language: language, story: story),
            ),
            Container(
              height: 280,
              child: Spiritual(language: language, spiritual:spiritual),
            ),
            Container(
              height: 280,
              child: Novels(language: language, novels:novels),
            ),
          ],
        ),
      ),
    );
  }
}

 //poetry category
class Poetry extends StatefulWidget {
  final String language;
  final String poetry;

  Poetry({required this.language, required this.poetry});

  @override
  State<StatefulWidget> createState() {
    return PoetryState();
  }
}

class PoetryState extends State<Poetry> {
  late Future<List<Book>> futureBooks;

  get language => widget.language;

  get poetry => widget.poetry;


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
            // padding: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Poetry',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => view(language: language, category: poetry),
                          ),
                        );

                      },
                      child: Text(
                        'View All',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
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
                                  truncateWords(book.name ?? 'Unknown', 3),
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


  Future<List<Book>> fetchBooks() async {
    String url = BASE_URL + "user_action/categories/category.php";
    final response = await http.get(
      Uri.parse('$url?language=${widget.language}&category=${widget.poetry}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = jsonResponse.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }


  String truncateWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    return words.take(maxWords).join(' ');
  }
}

//history category
class History extends StatefulWidget {
  final String language;
  final String history;

  History({required this.language, required this.history});

  @override
  State<StatefulWidget> createState() {
    return HistoryState();
  }
}

class HistoryState extends State<History> {
  late Future<List<Book>> futureBooks;

  get language => widget.language;

  get history => widget.history;

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
            //
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'History',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => view(language: language, category: history),
                          ),
                        );
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
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
                                  truncateWords(book.name ?? 'Unknown', 3),
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

  Future<List<Book>> fetchBooks() async {
    String url = BASE_URL + "user_action/categories/category.php";
    final response = await http.get(
      Uri.parse('$url?language=${widget.language}&category=${widget.history}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = jsonResponse.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }


  String truncateWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    return words.take(maxWords).join(' ');
  }
}

//story category

class Story extends StatefulWidget {
  final String language;
  final String story;

  Story({required this.language, required this.story});

  @override
  State<StatefulWidget> createState() {
    return StoryState();
  }
}

class StoryState extends State<Story>{
  late Future<List<Book>> futureBooks;

  get language => widget.language;

  get history => widget.story;

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
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Story',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => view(language: language, category: history),
                          ),
                        );
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
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
                                  truncateWords(book.name ?? 'Unknown', 3),
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

  Future<List<Book>> fetchBooks() async {
    String url = BASE_URL + "user_action/categories/category.php";
    final response = await http.get(
      Uri.parse('$url?language=${widget.language}&category=${widget.story}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = jsonResponse.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }


  String truncateWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    return words.take(maxWords).join(' ');
  }
}

//spiritual category
class Spiritual extends StatefulWidget {
  final String language;
  final String spiritual;

  Spiritual({required this.language, required this.spiritual});

  @override
  State<StatefulWidget> createState() {
    return SpiritualState();
  }
}

class SpiritualState extends State<Spiritual>{
  late Future<List<Book>> futureBooks;

  get language => widget.language;

  get spiritual => widget.spiritual;

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
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Spiritual',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => view(language: language, category: spiritual),
                          ),
                        );
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
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
                                  truncateWords(book.name ?? 'Unknown', 3),
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

  Future<List<Book>> fetchBooks() async {
    String url = BASE_URL + "user_action/categories/category.php";
    final response = await http.get(
      Uri.parse('$url?language=${widget.language}&category=${widget.spiritual}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = jsonResponse.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }


  String truncateWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    return words.take(maxWords).join(' ');
  }
}

// Novels category

class Novels extends StatefulWidget {
  final String language;
  final String novels ;

  Novels({required this.language, required this.novels});

  @override
  State<StatefulWidget> createState() {
    return NovelsState();
  }
}

class NovelsState extends State<Novels>{
  late Future<List<Book>> futureBooks;

  get language => widget.language;

  get novels => widget.novels;

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
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 0.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Novel',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => view(language: language, category: novels),
                          ),
                        );
                      },
                      child: Text(
                        'View All',
                        style: TextStyle(fontSize: 16, color: Colors.blue),
                      ),
                    ),
                  ),
                ),
              ],
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
                                  truncateWords(book.name ?? 'Unknown', 3),
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

  Future<List<Book>> fetchBooks() async {
    String url = BASE_URL + "user_action/categories/category.php";
    final response = await http.get(
      Uri.parse('$url?language=${widget.language}&category=${widget.novels}'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      List<Book> books = jsonResponse.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
  }


  String truncateWords(String text, int maxWords) {
    List<String> words = text.split(' ');
    return words.take(maxWords).join(' ');
  }
}

//in grid view
class view extends StatelessWidget {
  final String language;
  final String category;

  view({required this.language, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${category.capitalize()} books'),
      ),
      body: FutureBuilder<List<Book>>(
        future: fetchBooks(language, category),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Book> books = snapshot.data!;
            return GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 8.0, // Spacing between columns
                mainAxisSpacing: 8.0, // Spacing between rows
                childAspectRatio: 0.6, // Aspect ratio (width / height)
              ),
              itemCount: books.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookDetail(book: books[index]),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: Image.network(
                              books[index].imageUrl ?? '',
                              fit: BoxFit.cover,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  books[index].name!,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                // Text(books[index].author!),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}


//commented the usefull codes below

// this commented code has some more methods which is very usefull actually

//this is view all page


//in card view
// class view extends StatelessWidget {
//   final String language;
//   final String category;
//
//   view({required this.language, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${category.capitalize()} books'),
//       ),
//       body: FutureBuilder<List<Book>>(
//         future: fetchBooks(language, category),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Book> books = snapshot.data!;
//             return Container(
//               height: 500, // Set the height here
//               child: ListView.builder(
//                 itemCount: books.length,
//                 itemBuilder: (context, index) {
//                   return Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Card(
//                       child: ListTile(
//                         leading: Image.network(
//                           books[index].imageUrl ?? '',
//                           width: 100,
//                           height: 150,
//                           fit: BoxFit.cover,
//                         ),
//                         title: Text(books[index].name!),
//                         subtitle: Text(books[index].author!),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) => BookDetail(book: books[index]),
//                             ),
//                           );
//                         },
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//this is normal read now view
// class view extends StatelessWidget {
//   final String language;
//   final String category;
//
//   view({required this.language, required this.category});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('${category.capitalize()} books'),
//       ),
//       body: FutureBuilder<List<Book>>(
//         future: fetchBooks(language, category),
//         builder: (context, snapshot) {
//           if (snapshot.hasData) {
//             List<Book> book = snapshot.data!;
//             return ListView.builder(
//               itemCount: book.length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   leading: Container(
//                     decoration: BoxDecoration(
//                       border: Border.all(
//                         color: Colors.black,
//                         width: 1.0,
//                       ),
//                     ),
//                     child: Image.network(
//                       book[index].imageUrl ?? '',
//                       width: 90,
//                       height: 100,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                   title: Text(book[index].name!),
//                   subtitle: Text(book[index].author!),
//                   trailing: TextButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(
//                           builder: (context) => BookDetail(book: book[index]),
//                         ),
//                       );
//                     },
//                     child: Text('Read Now'),
//                   ),
//                 );
//               },
//             );
//           } else if (snapshot.hasError) {
//             return Center(
//               child: Text('Error: ${snapshot.error}'),
//             );
//           } else {
//             return Center(
//               child: CircularProgressIndicator(),
//             );
//           }
//         },
//       ),
//     );
//   }
// }

//capitalize funtion

extension StringExtension on String {
  String capitalize() {
    return this.isNotEmpty
        ? '${this[0].toUpperCase()}${this.substring(1)}'
        : '';
  }
}


Future<List<Book>> fetchBooks(String language, String category) async {
    String url = BASE_URL + "user_action/categories/viewall.php";
    final response = await http.get(
      Uri.parse('$url?language=$language&category=$category'),

    );
    print(response.body);
    if (response.statusCode == 200) {
      final List<dynamic> jsonResponse = jsonDecode(response.body);
      print('Total number of books: ${jsonResponse.length}');
      List<Book> books = jsonResponse.map((json) => Book.fromJson(json)).toList();
      return books;
    } else {
      throw Exception('Failed to load books: ${response.statusCode}');
    }
}
