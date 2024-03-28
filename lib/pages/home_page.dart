import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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
    await request.trendingMoviesRequest(context);
    await request.nowPlayingRequest();
    await request.topMoviesRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.7),
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
                          Padding(
                              padding: const EdgeInsets.all(10),
                              child: TextButton(
                                onPressed: () {
                                  movieSelected = request.topMovies![1];
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const MoviePage()));
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2,
                                    ),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: CachedNetworkImage(
                                      imageUrl:
                                          "${request.urlData.poster}${request.topMovies![1].background}",
                                      progressIndicatorBuilder:
                                          (context, url, downloadProgress) =>
                                              CircularProgressIndicator(
                                        value: downloadProgress.progress,
                                        color: const Color.fromARGB(
                                            255, 224, 23, 9),
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(Icons.error),
                                    ),
                                  ),
                                ),
                              )),
                          const Padding(
                            padding: EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Lançamentos',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 26),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: request.moviesNowPlaying!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            movieSelected = request
                                                .moviesNowPlaying![index];
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MoviePage(),
                                              ),
                                            );
                                          },
                                          child: SizedBox(
                                            height: 210,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                    "${request.urlData.poster}${request.moviesNowPlaying![index].poster}",
                                                placeholder: (context, url) =>
                                                    Container(
                                                        alignment:
                                                            Alignment.center,
                                                        child: const SizedBox(
                                                            width: 40,
                                                            height: 40,
                                                            child:
                                                                CircularProgressIndicator(
                                                              color: Colors.red,
                                                            ))),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        ),
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
                                      color: Colors.white, fontSize: 26),
                                ),
                              )),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: request.topMovies!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            movieSelected =
                                                request.topMovies![index];
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        const MoviePage()));
                                          },
                                          child: SizedBox(
                                              height: 210,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "${request.urlData.poster}${request.topMovies![index].poster}",
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const SizedBox(
                                                              width: 40,
                                                              height: 40,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    Colors.red,
                                                              ))),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              )),
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
                                      color: Colors.white, fontSize: 26),
                                ),
                              )),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: request.trendingMovies!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        TextButton(
                                            onPressed: () {
                                              movieSelected = request
                                                  .trendingMovies![index];
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          const MoviePage()));
                                            },
                                            child: SizedBox(
                                              height: 210,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                child: CachedNetworkImage(
                                                  imageUrl:
                                                      "${request.urlData.poster}${request.trendingMovies![index].poster}",
                                                  placeholder: (context, url) =>
                                                      Container(
                                                          alignment:
                                                              Alignment.center,
                                                          child: const SizedBox(
                                                              width: 40,
                                                              height: 40,
                                                              child:
                                                                  CircularProgressIndicator(
                                                                color:
                                                                    Colors.red,
                                                              ))),
                                                  errorWidget: (context, url,
                                                          error) =>
                                                      const Icon(Icons.error),
                                                ),
                                              ),
                                            )),
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
