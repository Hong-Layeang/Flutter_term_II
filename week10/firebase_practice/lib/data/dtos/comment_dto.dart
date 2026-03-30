import '../../model/comment/comment.dart';

class CommentDto {
  static const String textKey = 'text';
  static const String createdAtKey = 'createdAt';

  static Comment fromJson(String id, Map<String, dynamic> json) {
    assert(json[textKey] is String);
    assert(json[createdAtKey] is int);

    return Comment(
      id: id,
      text: json[textKey],
      createdAt: json[createdAtKey],
    );
  }

  /// Convert a comment text to JSON for POST
  static Map<String, dynamic> toJson(String text) {
    return {
      textKey: text,
      createdAtKey: DateTime.now().millisecondsSinceEpoch,
    };
  }
}
