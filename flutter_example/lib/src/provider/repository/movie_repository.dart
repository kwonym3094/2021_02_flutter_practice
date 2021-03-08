import 'dart:convert';

import 'package:flutter_example/src/provider/model/movie.dart';
import 'package:http/http.dart' as http;

class MovieRepository {
  Future<List<Movie>> loadMovies() async {
     // API 서버로 호출해서 값을 받아오는 부분
    var queryParam = {'api_key': '1d66c5df75c2e99c83900902ab9e76ce'};

    var uri =
        Uri.https('api.themoviedb.org', '/3/movie/popular', queryParam);
    var response = await http.get(uri);
    if (response.body != null) {
      Map<String, dynamic> body = json.decode(response.body);
      if (body['results'] != null) {
        List<dynamic> list = body['results'];
        return list.map<Movie>((item) => Movie.fromJson(item)).toList();
      }
    }
  }
}

