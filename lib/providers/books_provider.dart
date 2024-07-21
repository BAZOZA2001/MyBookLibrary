import 'package:flutter/foundation.dart';
import '../models/book.dart';

class BookNotFoundException implements Exception {
  final String message;
  BookNotFoundException(this.message);
}

class BooksProvider with ChangeNotifier {
  List<Book> _books = [];

  // Initialize with some dummy data for testing
  BooksProvider() {
    _books = [
      Book(id: '1', title: 'Book A', author: 'Author X', rating: 4.5, isRead: true),
      Book(id: '2', title: 'Book B', author: 'Author Y', rating: 3.8, isRead: false),
      Book(id: '3', title: 'Book C', author: 'Author Z', rating: 4.2, isRead: true),
    ];
  }

  List<Book> get books => [..._books];

  void addBook(Book book) {
    _books.add(book);
    notifyListeners();
  }

  void updateBook(String id, Book newBook) {
    final bookIndex = _books.indexWhere((book) => book.id == id);
    if (bookIndex >= 0) {
      _books[bookIndex] = newBook;
      notifyListeners();
    }
  }

  void deleteBook(String id) {
    _books.removeWhere((book) => book.id == id);
    notifyListeners();
  }

  List<Book> getSortedBooks(String sortOption) {
    switch (sortOption) {
      case 'byTitle':
        _books.sort((a, b) => a.title.compareTo(b.title));
        break;
      case 'byAuthor':
        _books.sort((a, b) => a.author.compareTo(b.author));
        break;
      case 'byRating':
        _books.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      default:
        // Default sort by title
        _books.sort((a, b) => a.title.compareTo(b.title));
    }
    return [..._books];
  }

  List<Book> searchBooks(String query) {
    return _books.where((book) => book.title.toLowerCase().contains(query.toLowerCase()) || book.author.toLowerCase().contains(query.toLowerCase())).toList();
  }

  Book findById(String id) {
    try {
      return _books.firstWhere((book) => book.id == id);
    } catch (e) {
      throw BookNotFoundException('Book with id $id not found');
    }
  }
}
