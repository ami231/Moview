import 'package:equatable/equatable.dart';
import 'package:moview/common/data/models/movie_model.dart';

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
  MoviesLoading() : super([], []);
}

class MoviesError extends MoviesState {
  MoviesError() : super([], []);

}

class MoviesNoInternetState extends MoviesState {
  MoviesNoInternetState() : super([], []);
}