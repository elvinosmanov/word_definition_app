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
    synonyms = json['synonyms'].cast<String>();
    antonyms = json['antonyms'].cast<String>();
    example = json['definitions'][0]["example"];
  }
}
