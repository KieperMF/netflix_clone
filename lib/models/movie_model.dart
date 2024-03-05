class Movie {
  String title;
  String overview;
  String release;
  double popularity;
  String poster;
  String background;

  Movie({
    required this.title,
    required this.overview,
    required this.release,
    required this.popularity,
    required this.poster,
    required this.background,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'],
        overview: json['overview'],
        release: json['release_date'],
        popularity: json['popularity'],
        poster: json['poster_path'],
        background: json['backdrop_path']);
  }
}
