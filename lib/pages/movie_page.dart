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
        title: Text("algum filme"),
      ),
      body: Center(
        child: Column(
          children: [
            if (movieSelected != null) ...[
              Image(
                  image: NetworkImage(
                      "${request.urlData.poster}${movieSelected!.poster}"))
            ] else ...[
              Text('erro'),
            ]
          ],
        ),
      ),
    );
  }
}
