import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final movieNameController = TextEditingController();

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
                  decoration: const InputDecoration(
                      hintText: 'Informe um Filme',
                      hintStyle: TextStyle(color: Colors.white, fontSize: 18)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
