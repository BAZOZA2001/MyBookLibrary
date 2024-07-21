// helpers/db_helper.dart

import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/book.dart';

class DBHelper {
  static Database? _database;
  static const String _dbName = 'book_library.db';
  static const String _tableName = 'books';

  DBHelper._(); // private constructor

  static final DBHelper instance = DBHelper._();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future<void> _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $_tableName(
        id TEXT PRIMARY KEY,
        title TEXT,
        author TEXT,
        rating REAL,
        isRead INTEGER
      )
    ''');
  }

  Future<int> addBook(Book book) async {
    Database db = await instance.database;
    return await db.insert(_tableName, book.toMap());
  }

  Future<int> updateBook(Book book) async {
    Database db = await instance.database;
    return await db.update(
      _tableName,
      book.toMap(),
      where: 'id = ?',
      whereArgs: [book.id],
    );
  }

  Future<int> deleteBook(String id) async {
    Database db = await instance.database;
    return await db.delete(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Book>> getBooks() async {
    Database db = await instance.database;
    List<Map<String, dynamic>> maps = await db.query(_tableName);
    return List.generate(maps.length, (i) {
      return Book(
        id: maps[i]['id'],
        title: maps[i]['title'],
        author: maps[i]['author'],
        rating: maps[i]['rating'],
        isRead: maps[i]['isRead'] == 1 ? true : false,
      );
    });
  }
}
