import 'package:flutter/cupertino.dart';
import 'package:flutter_example/src/provider/model/movie.dart';
import 'package:flutter_example/src/provider/repository/movie_repository.dart';

class MovieProvider extends ChangeNotifier {
  // 무조건 provider 에서 데이터 접근 !!
  MovieRepository _movieRepository = MovieRepository();

  List<Movie> _movies = [];
  List<Movie> get movies => _movies;
  loadMovies() async {
    //repository
    List<Movie> listMovies = await _movieRepository.loadMovies();
    // listMovies에 대해 예외처리
    // 추가 가공절차를 거침
    _movies = listMovies;
    notifyListeners();
  }

  String get postUrl => 'https://image.tmdb.org/t/p/w500/${this.postUrl}';
}
