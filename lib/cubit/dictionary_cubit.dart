import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:word_definition_app/repository/dictionary_repository.dart';

import '../model/dictionary.dart';

part 'dictionary_state.dart';

enum NetworkStatus { isOnline, isOffline }

class DictionaryCubit extends Cubit<DictionaryState> {
  final DictionaryRepository _dictionaryRepository;
  DictionaryCubit(this._dictionaryRepository) : super(DictionaryState.initial());
  // ignore: prefer_final_fields
  List<Dictionary> _dictionaries = [];
  getDictionary() async {
    if (state.dictionaryStatus == DictionaryStatus.loading) return;
    emit(state.copyWith(dictionaryStatus: DictionaryStatus.loading));

    try {
      var connectivityResult = await (Connectivity().checkConnectivity());
      if (connectivityResult == ConnectivityResult.none) {
        emit(state.copyWith(dictionaryStatus: DictionaryStatus.noInternet, searchText: ''));
      } else {
        final result = await _dictionaryRepository.getDictionary(state.searchText.trim());
        if (result != null) {
          _dictionaries.insert(0, result);
          emit(state.copyWith(dictionaryStatus: DictionaryStatus.success, dictionaries: _dictionaries, searchText: ''));
        } else {
          _dictionaries.insert(0, Dictionary(word: state.searchText));
          emit(
              state.copyWith(dictionaryStatus: DictionaryStatus.notFound, dictionaries: _dictionaries, searchText: ''));
        }
      }
    } catch (e) {
      emit(state.copyWith(dictionaryStatus: DictionaryStatus.error));
    }
  }

  searchTextChanged(String value) {
    emit(state.copyWith(searchText: value, dictionaryStatus: DictionaryStatus.initial));
  }
}
