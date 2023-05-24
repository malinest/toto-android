import 'dart:convert';
import 'dart:html';
import 'dart:io' as io;
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:toto_android/model/globals.dart';
import 'package:toto_android/model/strings.dart';
import '../model/board.dart';
import '../model/post.dart';

/// Handles all the api calls
class Api {
  /// Returns a list of every Post by date ascendant
  static Future<List<Post>> getAllPostsByDate() async {
    List<Board> boards = [];
    List<Post> posts = [];

    final uriBoard = Uri.http(Globals.API_URI, Globals.GET_BOARDS);
    final responseBoard = await http.get(uriBoard);

    List<dynamic> data = json.decode(responseBoard.body);

    if (responseBoard.statusCode == HttpStatus.ok) {
      for (var board in data) {
        boards.add(Board.fromJson(board));
        posts += await getPostsFromBoard(Board.fromJson(board).collectionName);
      }
      posts.sort((a, b) => b.date.compareTo(a.date));
      return posts;
    } else {
      throw Exception(Strings.failureGetDataMsg);
    }
  }

  /// Returns a list of every Board
  static Future<List<Board>> getAllBoards() async {
    List<Board> boards = [];

    final uriBoard = Uri.http(Globals.API_URI, Globals.GET_BOARDS);
    final responseBoard = await http.get(uriBoard);

    List<dynamic> data = json.decode(responseBoard.body);

    if (responseBoard.statusCode == HttpStatus.ok) {
      for (var board in data) {
        boards.add(Board.fromJson(board));
      }
      return boards;
    } else {
      throw Exception(Strings.failureGetDataMsg);
    }
  }

  /// Returns a list of every Post of a specified Board
  static Future<List<Post>> getPostsFromBoard(String collectionName) async {
    List<Post> posts = [];

    final queryParametersPost = {"board": collectionName};

    final uri =
        Uri.http(Globals.API_URI, Globals.GET_POSTS, queryParametersPost);
    final response = await http.get(uri);

    List<dynamic> data = json.decode(response.body);

    if (response.statusCode == HttpStatus.ok) {
      for (var post in data) {
        Post newPost = Post.fromJson(post);
        newPost.collectionName = collectionName;
        posts.add(newPost);
      }
      posts.sort((a, b) => b.date.compareTo(a.date));
      return posts;
    } else {
      throw Exception(Strings.failureGetDataMsg);
    }
  }

  /// Sends a Post creation request to the Api
  static Future<bool> createPost(String collectionName, String title,
      String username, String content, io.File file) async {
    final uri = Uri.parse(
            '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.CREATE_POST}')
        .replace(queryParameters: {"board": collectionName});

    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = title
      ..fields['username'] = username
      ..fields['content'] = content;
    if (file.path.endsWith('.jpg') ||
        file.path.endsWith('.jpeg') ||
        file.path.endsWith('.png') ||
        file.path.endsWith('.gif')) {
      request.files.add(http.MultipartFile.fromBytes(
          'media', file.readAsBytesSync(),
          contentType: MediaType('image', file.path.split('.').last),
          filename: file.path.split('/').last));
    } else if (file.path.endsWith('.mp4')) {
      request.files.add(http.MultipartFile.fromBytes(
          'media', file.readAsBytesSync(),
          contentType: MediaType('video', file.path.split('.').last),
          filename: file.path.split('/').last));
    } else {
      request.files.add(http.MultipartFile.fromBytes('media', [],
          contentType: MediaType('image', ''), filename: ''));
    }
    var response = await request.send();
    return response.statusCode == 302;
  }

  /// Sends a Comment creation request to the Api
  static Future<int> createComment(int postId, String collectionName,
      String responseTo, String username, String content, io.File file) async {
    final uri = Uri.parse(
            '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.CREATE_COMMENT}')
        .replace(queryParameters: {"board": collectionName});

    var request = http.MultipartRequest('POST', uri)
      ..fields['id'] = postId.toString()
      ..fields['response_to'] = responseTo
      ..fields['username'] = username
      ..fields['content'] = content;
    if (file.path.endsWith('.jpg') ||
        file.path.endsWith('.jpeg') ||
        file.path.endsWith('.png') ||
        file.path.endsWith('.gif')) {
      request.files.add(http.MultipartFile.fromBytes(
          'media', file.readAsBytesSync(),
          contentType: MediaType('image', file.path.split('.').last),
          filename: file.path.split('/').last));
    } else if (file.path.endsWith('.mp4')) {
      request.files.add(http.MultipartFile.fromBytes(
          'media', file.readAsBytesSync(),
          contentType: MediaType('video', file.path.split('.').last),
          filename: file.path.split('/').last));
    } else {
      request.files.add(http.MultipartFile.fromBytes('media', [],
          contentType: MediaType('image', ''), filename: ''));
    }
    var response = await request.send();
    return response.statusCode;
  }

  /// Sends a User creation request to the Api
  static Future<int> createUser(
      String username, String email, String password) async {
    final uri = Uri.parse(
        '${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.CREATE_USER}');

    var request = http.MultipartRequest('POST', uri)
      ..fields['password'] = password
      ..fields['username'] = username
      ..fields['email'] = email;
    var response = await request.send();
    return response.statusCode;
  }

  /// Sends a Log In request to the Api
  static Future<int> logIn(String username, String password) async {
    final uri =
        Uri.parse('${Globals.API_PROTOCOL}${Globals.API_URI}${Globals.LOG_IN}');

    var request = http.MultipartRequest('POST', uri)
      ..fields['password'] = password
      ..fields['username'] = username;
    var response = await request.send();
    return response.statusCode;
  }
}
