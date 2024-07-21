

class Book {
  final String id;
  final String title;
  final String author;
  final double rating;
  final bool isRead;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.rating,
    required this.isRead,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'rating': rating,
      'isRead': isRead ? 1 : 0, // Store as integer (1 for true, 0 for false)
    };
  }
}
