import 'meanings.dart';

class Dictionary {
  late String word;
  late List<Meanings>? meanings;

  Dictionary({required this.word, this.meanings});

  Dictionary.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    if (json['meanings'] != null) {
      meanings = <Meanings>[];
      json['meanings'].forEach((v) {
        meanings!.add(Meanings.fromJson(v));
      });
    }
  }
}
