import 'package:flutter_bloc/flutter_bloc.dart';

class SearchState {
  String searchText = '';
  SearchState({required this.searchText});
}

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchState(searchText: ''));

  void updateSearch({required String newText}) {
    emit(SearchState(searchText: newText));
  }
}