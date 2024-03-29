import 'package:flutter/material.dart';
import 'package:flutter_flix/request/http_request.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({super.key});

  @override
  State<MoviePage> createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  HttpRequest request = HttpRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black.withOpacity(0.7),
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        backgroundColor: Colors.grey[900],
        body: Stack(
          children: [
            Image(
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
                image: NetworkImage(
                    "${request.urlData.poster}${movieSelected!.background}")),
            Container(
              color: Colors.black.withOpacity(0.7),
              width: double.infinity,
              height: double.infinity,
            ),
            SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
                    if (movieSelected != null) ...[
                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                              height: 270,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Image(
                                    image: NetworkImage(
                                        "${request.urlData.poster}${movieSelected!.poster}")),
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          movieSelected!.title,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20),
                        ),
                      ),
                      Text("Data de Lançamento: ${movieSelected!.releaseDate}",
                          style: const TextStyle(
                              color: Colors.white, fontSize: 20)),
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                            "Popularidade: ${movieSelected!.popularity}",
                            style: const TextStyle(
                                color: Colors.white, fontSize: 20)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: SizedBox(
                          width: 350,
                          child: Text("Sinpse: ${movieSelected!.overview}",
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 20)),
                        ),
                      )
                    ]
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
