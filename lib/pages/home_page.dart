import 'package:flutter/material.dart';
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
    await request.nowPlayingRequest();
    await request.topMoviesRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Align(
            alignment: Alignment.center,
            child: Text(
              "Netflix",
              style: TextStyle(
                  color: Colors.red, fontSize: 28, fontWeight: FontWeight.bold),
            ),
          )),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ListenableBuilder(
                  listenable: request,
                  builder: (context, _) {
                    if (request.moviesNowPlaying != null && request.topMovies != null) {
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
                            height: 300,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: request.moviesNowPlaying!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                      padding: const EdgeInsets.all(15),
                                      child: SizedBox(
                                        width: 150,
                                        child: Column(
                                          children: [
                                            SizedBox(
                                              height: 190,
                                              child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(16),
                                                  child: Image.network(
                                                      '${request.urlData.poster}${request.moviesNowPlaying![index].poster}')),
                                            ),
                                            Text(
                                              request.moviesNowPlaying![index].title,
                                              style: const TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18),
                                            )
                                          ],
                                        ),
                                      ));
                                }),
                          ),
                        ],
                      );
                    } else {
                      return const Text("Erro ao carregar filmes", style: TextStyle(color: Colors.white),);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
