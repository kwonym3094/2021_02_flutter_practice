import 'dart:convert';

import 'package:flutter_example/model/movie.dart';
import 'package:http/http.dart' as http;

class WebService {
  Future<List<Movie>> fetchMovies(String keyword) async {
    final url = "http://www.omdbapi.com/?s=$keyword&apikey=eb0d5538";
    print(url);
    final response = await http.get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      final Iterable json = body['Search'];
      return json.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception("Unable to preform request!");
    }
  }
}