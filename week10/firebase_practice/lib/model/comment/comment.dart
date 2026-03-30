class Comment {
  final String id;
  final String text;
  final int createdAt; // timestamp in ms

  Comment({
    required this.id,
    required this.text,
    required this.createdAt,
  });

  @override
  String toString() {
    return 'Comment(id: $id, text: $text)';
  }
}
