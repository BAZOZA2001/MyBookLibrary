// screens/home_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/books_provider.dart';
import '../providers/settings_provider.dart';
import '../widgets/book_list.dart';
import '../widgets/search_bar_widget.dart';
import '../models/book.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final booksProvider = Provider.of<BooksProvider>(context);
    final sortedBooks = _getSortedBooks(context);
    final filteredBooks = booksProvider.searchBooks(_searchQuery);

    return Scaffold(
      appBar: AppBar(
        title: Text('Book Library'),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              Navigator.of(context).pushNamed('/settings');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SearchBarWidget(
            onSearch: (query) {
              setState(() {
                _searchQuery = query;
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Sort by:'),
                Consumer<SettingsProvider>(
                  builder: (context, settingsProvider, child) {
                    return DropdownButton<SortOption>(
                      value: settingsProvider.sortOption,
                      onChanged: (SortOption? newValue) {
  if (newValue != null) {
    settingsProvider.setSortOption(newValue);
  }
},

                      items: SortOption.values.map((SortOption value) {
                        return DropdownMenuItem<SortOption>(
                          value: value,
                          child: Text(value.toString().split('.').last),
                        );
                      }).toList(),
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: BookList(
              filteredBooks.isNotEmpty ? filteredBooks : sortedBooks,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.of(context).pushNamed('/add-edit-book');
        },
      ),
    );
  }

  List<Book> _getSortedBooks(BuildContext context) {
  final settingsProvider = Provider.of<SettingsProvider>(context);
  final sortOption = settingsProvider.sortOption;
  return Provider.of<BooksProvider>(context).getSortedBooks(sortOption.toString().split('.').last);
}

}
