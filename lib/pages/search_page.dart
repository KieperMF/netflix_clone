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
  HttpRequest _request = HttpRequest();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Pesquisa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.grey[900],
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                width: 250,
                child: TextField(
                  controller: movieNameController,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                      hintText: 'Informe um Filme',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18)),
                  onSubmitted: (value) {
                    _request.searchMoviesRequest(movieNameController.text);
                  },
                ),
              ),
              IconButton(
                  onPressed: () {
                    _request.searchMoviesRequest(movieNameController.text);
                  },
                  icon: const Icon(Icons.search)),
              ListenableBuilder(
                  listenable: _request,
                  builder: (context, _) {
                    if (_request.searchMovies != null) {
                      return Column(
                        children: [
                           ListView.builder(
                                shrinkWrap: true,
                                physics:const BouncingScrollPhysics(),
                                itemCount: _request.searchMovies!.length,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 200,
                                        child: ClipRRect(
                                          child: Image.network(
                                              "${_request.urlData.poster}${_request.searchMovies![index].poster}"),
                                        ),
                                      ),
                                      Text(
                                        _request.searchMovies![index].title,
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ],
                                  );
                                }),
                          
                        ],
                      );
                    } else {
                      return const Text('erro');
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
