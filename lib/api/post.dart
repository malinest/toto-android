import 'package:intl/intl.dart';
import 'comment.dart';

class Post {
  List<Comment> comments;
  String content;
  DateTime date;
  String filename;
  int? id;
  bool is_pinned;
  String title;
  String username;
  String? collectionName;

  Post(
      {required this.comments,
      required this.content,
      required this.date,
      required this.filename,
      required this.id,
      required this.is_pinned,
      required this.title,
      required this.username});

  factory Post.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];
    List<dynamic> data = json['comments'];
    DateFormat d = DateFormat("EEE, dd MMM yyyy hh:mm:ss zzz");
    for (var comment in data) {
      comments.add(Comment.fromJson(comment));
    }
    return Post(
        comments: comments,
        content: json['content'],
        date: d.parse(json['date']),
        filename: json['filename'],
        id: json['id'],
        is_pinned: json['is_pinned'],
        title: json['title'],
        username: json['username']);
  }
}
