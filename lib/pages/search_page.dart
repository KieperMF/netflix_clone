import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flix/request/http_request.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final movieNameController = TextEditingController();
  final _request = HttpRequest();

  @override
  void initState() {
    super.initState();
    _load();
  }

  void _load() {
    _request.trendingMoviesRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: 280,
            child: TextField(
              controller: movieNameController,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
              decoration: const InputDecoration(
                icon: Icon(Icons.search),
                  hintText: 'Pesquise séries e filmes',
                  hintStyle: TextStyle(color: Colors.white, fontSize: 16)),
              onSubmitted: (value) {
                _request.searchMoviesRequest(value);
              },
            ),
          ),
        ],
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              ListenableBuilder(
                  listenable: _request,
                  builder: (context, _) {
                    if (_request.searchMovies != null) {
                      return Column(
                        children: [
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _request.searchMovies!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 250,
                                        child: ClipRRect(
                                          child: Image.network(
                                              "${_request.urlData.poster}${_request.searchMovies![index].poster}"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 130,
                                        child: Text(
                                          _request.searchMovies![index].title,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 20),
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                        ],
                      );
                    } else if (_request.trendingMovies != null) {
                      return Column(
                        children: [
                          const Padding(
                              padding: EdgeInsets.all(10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Recomendados',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 24),
                                ),
                              )),
                          ListView.builder(
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              physics: const BouncingScrollPhysics(),
                              itemCount: _request.trendingMovies!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 250,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(16),
                                          child: Image.network(
                                              "${_request.urlData.poster}${_request.trendingMovies![index].poster}"),
                                        ),
                                      ),
                                      if (_request
                                              .trendingMovies![index].name !=
                                          null) ...[
                                        SizedBox(
                                          width: 130,
                                          child: Text(
                                            '${_request.trendingMovies![index].name}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )
                                      ] else ...[
                                        SizedBox(
                                          width: 130,
                                          child: Text(
                                            _request.trendingMovies![index].title,
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 20),
                                          ),
                                        )
                                      ],
                                    ],
                                  ),
                                );
                              }),
                        ],
                      );
                    } else {
                      return const Padding(
                          padding: EdgeInsets.only(top: 300),
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ));
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
