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
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              ListenableBuilder(
                  listenable: request,
                  builder: (context, _) {
                    if (request.moviesNowPlaying != null) {
                      return ListView.builder(
                          shrinkWrap: true,
                          physics: const BouncingScrollPhysics(),
                          itemCount: request.moviesNowPlaying!.length,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 200,
                                        width: 200,
                                        child: Image.network(
                                            '${request.urlData.poster}${request.moviesNowPlaying![index].poster}'))
                                  ],
                                ));
                          });
                    } else {
                      return const Text("Erro ao carregar filmes");
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}
