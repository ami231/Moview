import 'package:equatable/equatable.dart';
import 'package:moview/common/data/models/movie_model.dart';

abstract class MoviesEvent extends Equatable {
  moviesEvent();

  @override
  List<Object> get props => [];
}

class AddToFavoritesEvent extends MoviesEvent {
  final MovieModel newMovie;

  AddToFavoritesEvent(this.newMovie);

  @override
  List<Object> get props => [newMovie];

  @override
  moviesEvent() {
    throw UnimplementedError();
  }

}

class RemoveFromFavoritesEvent extends MoviesEvent {
  final MovieModel oldMovie;

  RemoveFromFavoritesEvent(this.oldMovie);

  @override
  List<Object> get props => [oldMovie];

  @override
  moviesEvent() {
    throw UnimplementedError();
  }
}

class AddToAllMoviesEvent extends MoviesEvent {
  final MovieModel newMovie;

  AddToAllMoviesEvent(this.newMovie);

  @override
  moviesEvent() {
    throw UnimplementedError();
  }

  @override
  List<Object> get props => [newMovie];
}

class LoadMoviesEvent extends MoviesEvent {
  final dynamic context;

  LoadMoviesEvent(this.context);

  @override
  moviesEvent() {
    throw UnimplementedError();
  }
}

class NoInternetEvent extends MoviesEvent {
  @override
  moviesEvent() {
    throw UnimplementedError();
  }
}
