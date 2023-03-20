import 'package:equatable/equatable.dart';
import 'package:moview/models/movie_model.dart';

abstract class MoviesState extends Equatable {
  final List<MovieModel> favoritesList;
  final List<MovieModel> allMoviesList;

  const MoviesState(this.favoritesList, this.allMoviesList);

  @override
  List<Object> get props => [favoritesList, allMoviesList];
}

class MoviesInitial extends MoviesState {
  MoviesInitial() : super([], []);
}

class MoviesLoaded extends MoviesState {
  const MoviesLoaded(List<MovieModel> favoritesList, List<MovieModel> allMoviesList)
      : super(favoritesList, allMoviesList);
}

class MoviesLoading extends MoviesState {
  const MoviesLoading(List<MovieModel> favoritesList, List<MovieModel> allMoviesList) : super(favoritesList, allMoviesList);
}

class MoviesError extends MoviesState {
  const MoviesError(List<MovieModel> favoritesList, List<MovieModel> allMoviesList) : super(favoritesList, allMoviesList);
}