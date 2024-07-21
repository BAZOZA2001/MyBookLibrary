// widgets/book_list.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/books_provider.dart';
import '../screens/book_detail_screen.dart';

class BookList extends StatelessWidget {
  final List<Book> books;

  BookList(this.books);

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context, listen: false);

    return ListView.builder(
      itemCount: books.length,
      itemBuilder: (ctx, index) {
        return ListTile(
          title: Text(books[index].title),
          subtitle: Text('by ${books[index].author}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  booksProvider.deleteBook(books[index].id);
                },
              ),
              Icon(Icons.arrow_forward),
            ],
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              BookDetailScreen.routeName,
              arguments: books[index].id,
            );
          },
        );
      },
    );
  }
}
