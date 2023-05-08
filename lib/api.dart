import 'dart:convert';
import 'package:http/http.dart' as http;
import 'Album.dart';

Future<Album> fetchData() async {
  final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/albums/2'));

  if (response.statusCode == 200) {
    return Album.fromJson(jsonDecode(response.body));
  } else {
    throw Exception('Failed to load Album');
  }
}