class Movie {
  String title;
  String overview;
  String releaseDate;
  double popularity;
  String? poster;
  String? background;
  String? mediaType;
    String? name;

  Movie({
    required this.name,
    required this.title,
    required this.overview,
    required this.releaseDate,
    required this.popularity,
    required this.poster,
    required this.background,
    required this.mediaType,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
        title: json['title'] ,
        overview: json['overview'],
        releaseDate: json['release_date'],
        popularity: json['popularity'],
        poster: json['poster_path'],
        mediaType: json['media_type'],
        name: json['name'],
        background: json['backdrop_path']);
  }
}
