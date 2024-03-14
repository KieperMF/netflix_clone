import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flix/models/movie_model.dart';
import 'package:flutter_flix/models/url_data.dart';
import 'package:http/http.dart' as http;

Movie? movieSelected;

class HttpRequest extends ChangeNotifier {
  List<Movie>? moviesNowPlaying;
  List<Movie>? topMovies;
  List<Movie>? searchMovies;
  List<Movie>? trendingMovies;
  //Movie? movieSelected;
  UrlData urlData = UrlData();

  movieNowPlaySelection(int index) {
    movieSelected = moviesNowPlaying![index];
    print('${movieSelected!.title}');
    notifyListeners();
  }

  Future<void> trendingMoviesRequest(BuildContext context) async {
    try {
      Uri uri =
          Uri.parse("${urlData.trending}${urlData.apiKey}${urlData.ptBr}");
      final response = await http.get(uri);
      final decode = jsonDecode(response.body)['results'] as List;
      trendingMovies = decode.map((json) => Movie.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocorreu um erro ao carregar os filmes.'),
        ),
      );
    }
  }

  Future<void> nowPlayingRequest() async {
    try {
      Uri uri =
          Uri.parse("${urlData.urlNowPlaying}${urlData.apiKey}${urlData.ptBr}");
      final response = await http.get(uri);
      final decode = jsonDecode(response.body)['results'] as List;
      moviesNowPlaying = decode.map((json) => Movie.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> topMoviesRequest() async {
    try {
      Uri uri =
          Uri.parse("${urlData.topMovies}${urlData.apiKey}${urlData.ptBr}");
      final response = await http.get(uri);
      final decode = jsonDecode(response.body)['results'] as List;
      topMovies = decode.map((json) => Movie.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {}
  }

  Future<void> searchMoviesRequest(
      String inputName, BuildContext context) async {
    try {
      Uri uri = Uri.parse(
          "${urlData.searchMovies}$inputName${urlData.apiKey}${urlData.ptBr}");
      final response = await http.get(uri);
      final decode = jsonDecode(response.body)['results'] as List;
      searchMovies = decode.map((json) => Movie.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Ocorreu um erro ao carregar os filmes.'),
        ),
      );
    }
  }
}
