import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_flix/models/movie_model.dart';
import 'package:flutter_flix/models/trendig.dart';
import 'package:flutter_flix/models/url_data.dart';
import 'package:http/http.dart' as http;

class HttpRequest extends ChangeNotifier {
  List<Movie>? moviesNowPlaying;
  List<Movie>? topMovies;
  List<Movie>? searchMovies;
  List<TrendingMovies>? trendingMovies;
  Movie? movieSelected;
  UrlData urlData = UrlData();

  Future<void> trendingMoviesRequest() async {
    try {
      Uri uri =
          Uri.parse("${urlData.trending}${urlData.apiKey}${urlData.ptBr}");
      final response = await http.get(uri);
      final decode = jsonDecode(response.body)['results'] as List;
      trendingMovies =
          decode.map((json) => TrendingMovies.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {}
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
    } catch (e) {
      print("Erro $e");
    }
  }

  Future<void> searchMoviesRequest(String inputName) async {
    try {
      Uri uri = Uri.parse(
          "${urlData.searchMovies}$inputName${urlData.apiKey}${urlData.ptBr}");
      final response = await http.get(uri);
      final decode = jsonDecode(response.body)['results'] as List;
      searchMovies = decode.map((json) => Movie.fromJson(json)).toList();
      notifyListeners();
    } catch (e) {
      print("erro $e");
    }
  }
}
