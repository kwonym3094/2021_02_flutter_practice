class Movie {
  String title;
  String overview;
  String posterPath;

  Movie({this.overview, this.title, this.posterPath});

  // json으로 jsonParser 를 통해 객체로 만들어져야 함
  // factory 패턴으로 작성
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      overview: json['overview'] as String,
      title: json['title'] as String,
      posterPath: json['poster_path'] as String,
    );
  }
  String get postUrl => 'https://image.tmdb.org/t/p/w500/${this.posterPath}';
}
