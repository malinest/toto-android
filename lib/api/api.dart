import 'dart:convert';

import 'package:http/http.dart' as http;
import 'board.dart';
import 'post.dart';

Future<List<Post>> getAllPostsByDate() async {
  List<Board> boards = [];
  List<Post> posts = [];

  final uriBoard = Uri.http('5.196.29.178:5000', '/api/get_boards');
  final responseBoard = await http.get(uriBoard);
  
  List<dynamic> data = json.decode(responseBoard.body);

  if (responseBoard.statusCode == 200) {
    for (var board in data) {
      boards.add(Board.fromJson(board));
      print(Board.fromJson(board).name);
      posts += await getPostsFromBoard(Board.fromJson(board).collectionName);
    }
    posts.sort((a, b) => b.date.compareTo(a.date));
    posts.forEach((post) {
      print(post.title);
      print(post.date);
    });
    return posts;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Post>> getPostsFromBoard(String collectionName) async {
  List<Post> posts = [];

  final queryParametersPost = {
    "board": collectionName
  };

  final uri = Uri.http('5.196.29.178:5000', '/api/get_posts', queryParametersPost);
  final response = await http.get(uri);

  List<dynamic> data = json.decode(response.body);

  if (response.statusCode == 200) {
    for (var post in data) {
      posts.add(Post.fromJson(post));
    }
    return posts;
  } else {
    throw Exception('Failed to load data');
  }
}