class UrlData{
  String urlNowPlaying;
  String topMovies;
  String searchMovies;
  String ptBr;
  String apiKey;
  String poster;
  String trending;

  UrlData({
    this.topMovies = "https://api.themoviedb.org/3/movie/top_rated?",
    this.urlNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?",
    this.searchMovies = "https://api.themoviedb.org/3/search/movie?query=",
    this.apiKey = "&api_key=65eb24d3d4ad7bfdd3aa23d86fc0cf6a",
    this.poster = "https://image.tmdb.org/t/p/original/",
    this.ptBr = "&language=pt-BR",
    this.trending = "https://api.themoviedb.org/3/trending/all/day?"
  });
}