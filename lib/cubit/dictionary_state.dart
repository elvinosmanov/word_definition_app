part of 'dictionary_cubit.dart';

enum DictionaryStatus { initial, loading, success, notFound, error }

class DictionaryState extends Equatable {
  final DictionaryStatus dictionaryStatus;
  final List<Dictionary> dictionaries;
  

  const DictionaryState({required this.dictionaryStatus, required this.dictionaries});
  factory DictionaryState.initial() {
    return  const DictionaryState(dictionaryStatus: DictionaryStatus.initial, dictionaries:[]);
  }

  @override
  List<Object?> get props => [dictionaries, dictionaryStatus];

  DictionaryState copyWith({
    DictionaryStatus? dictionaryStatus,
    List<Dictionary>? dictionaries,
  }) {
    return DictionaryState(
      dictionaryStatus: dictionaryStatus ?? this.dictionaryStatus,
      dictionaries: dictionaries ?? this.dictionaries,
    );
  }
}
