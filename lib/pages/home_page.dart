import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_flix/pages/movie_page.dart';
import 'package:flutter_flix/pages/search_page.dart';
import 'package:flutter_flix/request/http_request.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HttpRequest request = HttpRequest();

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    await request.trendingMoviesRequest();
    await request.nowPlayingRequest();
    await request.topMoviesRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Align(
          alignment: Alignment.topLeft,
          child: Text(
            "N",
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: ((context) => const SearchPage())));
            },
            icon: const Icon(Icons.search),
            color: Colors.white,
          ),
        ],
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ListenableBuilder(
                  listenable: request,
                  builder: (context, _) {
                    if (request.moviesNowPlaying != null &&
                        request.topMovies != null) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Lançamentos',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 22),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 320,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: request.moviesNowPlaying!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            request.movieSelected = request
                                                .moviesNowPlaying![index];
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MoviePage()));
                                          },
                                          child: SizedBox(
                                            height: 180,
                                            width: 120,
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                    '${request.urlData.poster}${request.moviesNowPlaying![index].poster}')),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                            '${request
                                                .moviesNowPlaying![index].title}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Melhores Filmes',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              )),
                          SizedBox(
                            height: 320,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: request.topMovies!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            request.movieSelected =
                                                request.topMovies![index];
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MoviePage()));
                                          },
                                          child: SizedBox(
                                              height: 180,
                                              width: 120,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                    "${request.urlData.poster}${request.topMovies![index].poster}"),
                                              )),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          child: Text(
                                            '${request.topMovies![index].title}',
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 18),
                                          ),
                                        ),
                                      ],
                                    ));
                              },
                            ),
                          ),
                          const Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Em Alta',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                              )),
                          SizedBox(
                            height: 320,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: request.trendingMovies!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              request.movieSelected =
                                                  request
                                                      .trendingMovies![index];
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MoviePage()));
                                            },
                                            child: SizedBox(
                                              width: 120,
                                              height: 180,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: Image.network(
                                                    "${request.urlData.poster}${request.trendingMovies![index].poster}"),
                                              ),
                                            )),
                                        if (request
                                                .trendingMovies![index].name !=
                                            null) ...[
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              '${request.trendingMovies![index].name}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ] else ...[
                                          SizedBox(
                                            width: 120,
                                            child: Text(
                                              '${request.trendingMovies![index].title}',
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            ),
                                          )
                                        ],
                                      ],
                                    ),
                                  );
                                }),
                          )
                        ],
                      );
                    } else {
                      return const Padding(
                          padding: EdgeInsets.only(top: 300),
                          child: CircularProgressIndicator(
                            color: Colors.red,
                          ));
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
