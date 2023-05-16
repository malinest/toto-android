import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:toto_android/globals.dart';
import 'board.dart';
import 'post.dart';

Future<List<Post>> getAllPostsByDate() async {
  List<Board> boards = [];
  List<Post> posts = [];

  final uriBoard = Uri.http(Globals.API_URI, Globals.GET_BOARDS);
  final responseBoard = await http.get(uriBoard);
  
  List<dynamic> data = json.decode(responseBoard.body);

  if (responseBoard.statusCode == 200) {
    for (var board in data) {
      boards.add(Board.fromJson(board));
      posts += await getPostsFromBoard(Board.fromJson(board).collectionName);
    }
    posts.sort((a, b) => b.date.compareTo(a.date));
    return posts;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Board>> getAllBoards() async {
  print('getAllBoards');
  List<Board> boards = [];

  final uriBoard = Uri.http(Globals.API_URI, Globals.GET_BOARDS);
  final responseBoard = await http.get(uriBoard);

  List<dynamic> data = json.decode(responseBoard.body);

  if (responseBoard.statusCode == 200) {
    for (var board in data) {
      boards.add(Board.fromJson(board));
    }
    return boards;
  } else {
    throw Exception('Failed to load data');
  }
}

Future<List<Post>> getPostsFromBoard(String collectionName) async {
  List<Post> posts = [];

  final queryParametersPost = {
    "board": collectionName
  };

  final uri = Uri.http(Globals.API_URI, Globals.GET_POSTS, queryParametersPost);
  final response = await http.get(uri);

  List<dynamic> data = json.decode(response.body);

  if (response.statusCode == 200) {
    for (var post in data) {
      posts.add(Post.fromJson(post));
    }
    posts.sort((a, b) => b.date.compareTo(a.date));
    return posts;
  } else {
    throw Exception('Failed to load data');
  }
}