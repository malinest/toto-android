class Comment {
  final int? id;
  final String content;
  final String date;
  final String filename;
  final String responseTo;
  final String username;

  Comment({required this.id, required this.content, required this.date, required this.filename, required this.responseTo, required this.username});

  factory Comment.fromJson(Map<String, dynamic> json){
    if(json['filename'] != null) {
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