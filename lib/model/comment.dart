// Model of a Comment
class Comment {
  // Id of the comment
  final int? id;
  // Content of the comment
  final String content;
  // Date of the comment posted
  final String date;
  // Filename of the comment (not required)
  final String filename;
  // Whom the comment is responding to
  final String responseTo;
  // Author of the comment
  final String username;

  Comment(
      {required this.id,
      required this.content,
      required this.date,
      required this.filename,
      required this.responseTo,
      required this.username});

  factory Comment.fromJson(Map<String, dynamic> json) {
    if (json['filename'] != null) {
      return Comment(
        id: json['_id'],
        content: json['content'],
        date: json['date'],
        filename: json['filename'],
        responseTo: json['response_to'],
        username: json['username'],
      );
    } else {
      return Comment(
        id: json['_id'],
        content: json['content'],
        date: json['date'],
        filename: '',
        responseTo: json['response_to'],
        username: json['username'],
      );
    }
  }
}
