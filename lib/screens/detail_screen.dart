import 'package:flutter/material.dart';

import 'package:word_definition_app/model/meanings.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({
    Key? key,
    required this.meanings,
  }) : super(key: key);
  final List<Meanings> meanings;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Screen'),
      ),
      body: Column(
        children: [
          Text(meanings[0].definition ?? 'No definition'),
          Text(meanings[0].example ?? 'No example'),
          for (String i in meanings[0].antonyms!) Text("$i"),
        ],
      ),
    );
  }
}
