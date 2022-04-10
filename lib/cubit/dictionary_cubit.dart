import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:word_definition_app/repository/dictionary_repository.dart';

import '../model/dictionary.dart';

part 'dictionary_state.dart';

class DictionaryCubit extends Cubit<DictionaryState> {
  final DictionaryRepository _dictionaryRepository;
  DictionaryCubit(this._dictionaryRepository) : super(DictionaryState.initial());
  // ignore: prefer_final_fields
  List<Dictionary?> _dictionaries = [];

  getDictionary(String word) async {
    if (state.dictionaryStatus == DictionaryStatus.loading) return;
    emit(state.copyWith(dictionaryStatus: DictionaryStatus.loading));
    final result = await _dictionaryRepository.getDictionary(word);
    try {
      if (result != null) {
        _dictionaries.add(result);
        emit(
            state.copyWith(dictionaryStatus: DictionaryStatus.success, dictionaries: _dictionaries));
      } else {
        _dictionaries.add(Dictionary(word: word));
        emit(state.copyWith(dictionaryStatus: DictionaryStatus.notFound, dictionaries: _dictionaries));
      }
    } catch (e) {
      emit(state.copyWith(dictionaryStatus: DictionaryStatus.error));
    }
  }
}
