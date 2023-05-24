import 'package:intl/intl.dart';
import 'comment.dart';

/// Model of a Post
class Post {
  // Comments of the Post
  List<Comment> comments;
  // Content  of the Post
  String content;
  // Date of the Post posted
  DateTime date;
  // Filename of the Post (not required)
  String filename;
  // Id of the Post
  int? id;
  // If the Post is Pinned on the Board
  bool isPinned;
  // Title of the Post
  String title;
  // Author of the Post
  String username;
  // Name of the collection where the Post is stored
  String? collectionName;

  Post(
      {required this.comments,
      required this.content,
      required this.date,
      required this.filename,
      required this.id,
      required this.isPinned,
      required this.title,
      required this.username});

  factory Post.fromJson(Map<String, dynamic> json) {
    List<Comment> comments = [];
    List<dynamic> data = json['comments'];
    DateFormat d = DateFormat("EEE, dd MMM yyyy hh:mm:ss zzz");
    for (var comment in data) {
      comments.add(Comment.fromJson(comment));
    }
    if (json['filename'] != null) {
      return Post(
        comments: comments,
        content: json['content'],
        date: d.parse(json['date']),
        filename: json['filename'],
        id: json['id'],
        isPinned: json['is_pinned'],
        title: json['title'],
        username: json['username'],
      );
    } else {
      return Post(
        comments: comments,
        content: json['content'],
        date: d.parse(json['date']),
        filename: '',
        id: json['id'],
        isPinned: json['is_pinned'],
        title: json['title'],
        username: json['username'],
      );
    }
  }
}
