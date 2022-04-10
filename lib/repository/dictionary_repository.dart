import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:word_definition_app/model/dictionary.dart';

class DictionaryRepository {
  final String baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";
  Future<Dictionary?> getDictionary(String word) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl$word"));
      if (response.statusCode == 200) {
        // print(response.body);
        return Dictionary.fromJson(jsonDecode(response.body)[0]);
      } else {
        return null;
      }
    } catch (error) {
      rethrow;
    }
  }
}
