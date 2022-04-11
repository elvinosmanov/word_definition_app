part of 'dictionary_cubit.dart';

enum DictionaryStatus { initial, loading, success, notFound, noInternet, error }

class DictionaryState extends Equatable {
  final DictionaryStatus dictionaryStatus;
  final List<Dictionary> dictionaries;
  final String searchText;

  const DictionaryState({required this.dictionaryStatus, required this.dictionaries, required this.searchText});
  factory DictionaryState.initial() {
    return const DictionaryState(dictionaryStatus: DictionaryStatus.initial, dictionaries: [], searchText: "");
  }

  @override
  List<Object?> get props => [dictionaries, dictionaryStatus, searchText];

  DictionaryState copyWith({
    DictionaryStatus? dictionaryStatus,
    List<Dictionary>? dictionaries,
    String? searchText,
  }) {
    return DictionaryState(
      dictionaryStatus: dictionaryStatus ?? this.dictionaryStatus,
      dictionaries: dictionaries ?? this.dictionaries,
      searchText: searchText ?? this.searchText,
    );
  }
}
