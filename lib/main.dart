import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_definition_app/repository/dictionary_repository.dart';
import 'package:word_definition_app/screens/first_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Word Definition App',
      home: RepositoryProvider(
        
        create: (context) => DictionaryRepository(),
        child: const FirstPage(),
      ),
    );
  }
}
