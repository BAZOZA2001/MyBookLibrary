import 'package:flutter/material.dart';
import '../models/book.dart';

class BookListItem extends StatelessWidget {
  final Book book;

  BookListItem({required this.book});  // Ensure the constructor accepts a Book object

  @override
  Widget build(BuildContext context) {
    // Build your UI using the book data
    return ListTile(
      title: Text(book.title),
      subtitle: Text(book.author),
      // Add more widgets to display other book details as needed
    );
  }
}
