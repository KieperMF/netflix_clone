class UrlData{
  String urlNowPlaying;
  String ptBr;
  String apiKey;
  String poster;

  UrlData({
    this.urlNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?",
    this.apiKey = "&api_key=65eb24d3d4ad7bfdd3aa23d86fc0cf6a",
    this.poster = "https://image.tmdb.org/t/p/original/",
    this.ptBr = "&language=pt-BR",
  });
}