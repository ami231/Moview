import 'package:flutter_bloc/flutter_bloc.dart';

class GenreState {
  String genre = 'All';
  GenreState({required this.genre});
}

class GenreCubit extends Cubit<GenreState> {
  GenreCubit() : super(GenreState(genre: ''));

  void updateGenre({required String newGenre}) {
    emit(GenreState(genre: newGenre));
  }
}