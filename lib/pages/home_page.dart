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
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Netflix"),
      ),
      backgroundColor: Colors.grey[900],
      body: Center(
        child: Column(
          children: [
            ListenableBuilder(
                listenable: request,
                builder: (context, _) {
                  if (request.moviesNowPlaying != null) {
                    return Column(
                      children: [
                        SizedBox(
                          height: 250,
                          child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: request.moviesNowPlaying!.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column(
                                      children: [
                                        SizedBox(
                                          height: 170,
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: Image.network(
                                                  '${request.urlData.poster}${request.moviesNowPlaying![index].poster}')),
                                        ),
                                        Text(
                                          request
                                              .moviesNowPlaying![index].title,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        )
                                      ],
                                    ));
                              }),
                        ),
                      ],
                    );
                  } else {
                    return const Text("Erro ao carregar filmes");
                  }
                })
          ],
        ),
      ),
    );
  }
}
