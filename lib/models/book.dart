import '../constants.dart';

class Book {
  final String? id;
  final String? name;
  final String? author;
  final String? description;
  final String? imageUrl;
  final String? pdfUrl;
  Book({required this.id, required this.name, required this.author, required this.description, required this.imageUrl, required this.pdfUrl});

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['bookid'],
      name: json['bookname'],
      author: json['bookauthor'],
      description: json['bookdescription'],
      imageUrl: BASE_URL+"admin/"+ json['bookimage'],
      pdfUrl: BASE_URL+"admin/"+ json['bookfile'],
    );
  }
}



