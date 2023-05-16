class Comment {
  final int? id;
  final String content;
  final String date;
  final String filename;
  final int? responseTo;
  final String username;

  Comment({required this.id, required this.content, required this.date, required this.filename, required this.responseTo, required this.username});

  factory Comment.fromJson(Map<String, dynamic> json){
    return Comment(
      id: json['_id'],
      content: json['content'],
      date: json['date'],
      filename: json['filename'],
      responseTo: json['responseTo'],
      username: json['username'],
    );
  }
}