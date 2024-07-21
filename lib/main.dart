// main.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/add_edit_book_screen.dart';
import 'screens/book_detail_screen.dart';
import 'providers/books_provider.dart';
import 'providers/settings_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BooksProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: Consumer<SettingsProvider>(
        builder: (ctx, settings, _) => MaterialApp(
          title: 'Book Library',
          theme: settings.isDarkMode ? ThemeData.dark() : ThemeData.light(),
          home: HomeScreen(),
          routes: {
            '/settings': (ctx) => SettingsScreen(),
            '/add-edit-book': (ctx) => AddEditBookScreen(),
            BookDetailScreen.routeName: (ctx) => BookDetailScreen(),
          },
        ),
      ),
    );
  }
}
