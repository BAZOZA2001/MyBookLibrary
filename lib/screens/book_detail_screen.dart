// screens/book_detail_screen.dart

// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/books_provider.dart';

class BookDetailScreen extends StatelessWidget {
  static const routeName = '/book-detail';

  @override
  Widget build(BuildContext context) {
    final bookId = ModalRoute.of(context)!.settings.arguments as String; // Replace '?.' with '!'
    final selectedBook = Provider.of<BooksProvider>(context, listen: false).findById(bookId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedBook.title),
      ),
      body: selectedBook == null
          ? Center(child: Text('Book not found'))
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: BookDetails(book: selectedBook),
            ),
    );
  }
}

class BookDetails extends StatelessWidget {
  final Book book;

  BookDetails({required this.book});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          book.title,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 8),
        Text(
          'Author: ${book.author}',
          style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Rating: ${book.rating}',
              style: TextStyle(fontSize: 18),
            ),
            Icon(
              Icons.star,
              color: Colors.amber,
            ),
          ],
        ),
        SizedBox(height: 16),
        Text(
          'Read: ${book.isRead ? 'Yes' : 'No'}',
          style: TextStyle(fontSize: 18),
        ),
        SizedBox(height: 16),
        ElevatedButton.icon(
          onPressed: () {
            Navigator.of(context).pushNamed(
              '/add-edit-book',
              arguments: book.id,
            );
          },
          icon: Icon(Icons.edit),
          label: Text('Edit Book'),
        ),
      ],
    );
  }
}
