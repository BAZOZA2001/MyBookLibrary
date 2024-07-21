import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/book.dart';
import '../providers/books_provider.dart';

class AddEditBookScreen extends StatefulWidget {
  static const routeName = '/add-edit-book';

  @override
  _AddEditBookScreenState createState() => _AddEditBookScreenState();
}

class _AddEditBookScreenState extends State<AddEditBookScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _author = '';
  double _rating = 0.0;
  bool _isRead = false;
  bool _isInit = true;
  Book? _editedBook;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_isInit) {
      final bookId = ModalRoute.of(context)?.settings.arguments as String?;
      if (bookId != null) {
        _editedBook = Provider.of<BooksProvider>(context, listen: false).findById(bookId);
        if (_editedBook != null) {
          _title = _editedBook!.title;
          _author = _editedBook!.author;
          _rating = _editedBook!.rating;
          _isRead = _editedBook!.isRead;
        }
      }
      _isInit = false;
    }
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_editedBook == null) {
        Provider.of<BooksProvider>(context, listen: false).addBook(
          Book(
            id: DateTime.now().toString(),
            title: _title,
            author: _author,
            rating: _rating,
            isRead: _isRead,
          ),
        );
      } else {
        Provider.of<BooksProvider>(context, listen: false).updateBook(
          _editedBook!.id,
          Book(
            id: _editedBook!.id,
            title: _title,
            author: _author,
            rating: _rating,
            isRead: _isRead,
          ),
        );
      }
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_editedBook == null ? 'Add Book' : 'Edit Book'),
        actions: [
          IconButton(
            icon: Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _title = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a title.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _author,
                decoration: InputDecoration(labelText: 'Author'),
                textInputAction: TextInputAction.next,
                onSaved: (value) {
                  _author = value!;
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide an author.';
                  }
                  return null;
                },
              ),
              TextFormField(
                initialValue: _rating.toString(),
                decoration: InputDecoration(labelText: 'Rating'),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                onSaved: (value) {
                  _rating = double.parse(value!);
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please provide a rating.';
                  }
                  return null;
                },
              ),
              SwitchListTile(
                title: Text('Read'),
                value: _isRead,
                onChanged: (value) {
                  setState(() {
                    _isRead = value;
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
