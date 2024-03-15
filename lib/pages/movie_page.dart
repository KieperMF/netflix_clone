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
        title: const Text("algum filme"),
      ),
      backgroundColor: Colors.grey,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (movieSelected != null) ...[
              SizedBox(
                height: 200,
                child: Image(
                  image: NetworkImage(
                      "${request.urlData.poster}${movieSelected!.poster}")),
              )
            ]
          ],
        ),
      ),
    );
  }
}
