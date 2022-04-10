class Dictionary {
  late String word;
  List<Meanings>? meanings;


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

  Dictionary copyWith({
    String? word,
    List<Meanings>? meanings,
  }) {
    return Dictionary(
      word: word ?? this.word,
      meanings: meanings ?? this.meanings,
    );
  }
}

//only one definiton have taken for each part of speech
class Meanings {
  String? partOfSpeech;
  String? definition;
  List<String>? synonyms;
  List<String>? antonyms;
  String? example;
  Meanings({this.partOfSpeech, this.definition, this.synonyms, this.antonyms, this.example});

  Meanings.fromJson(Map<String, dynamic> json) {
    partOfSpeech = json['partOfSpeech'];
    definition = json['definitions'][0]["definition"];
    synonyms = json['definitions'][0]['synonyms'].cast<String>();
    antonyms = json['definitions'][0]['antonyms'].cast<String>();
    example = json['definitions'][0]["example"];
  }
}
