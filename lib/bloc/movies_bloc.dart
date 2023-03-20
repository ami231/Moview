import 'package:bloc/bloc.dart';
import 'package:moview/bloc/movies_event.dart';
import 'package:moview/bloc/movies_state.dart';
import 'package:moview/models/movie_model.dart';
import 'package:moview/services/load_movies.dart';


class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  MoviesBloc() : super(MoviesInitial());

  @override
  Stream<MoviesState> mapEventToState(MoviesEvent event) async* {
    if (event is AddToFavoritesEvent) {
      yield* _mapAddToFavorites(event);
    }
    else if (event is RemoveFromFavoritesEvent) {
      yield* _mapRemoveFromFavorites(event);
    }
    else if (event is AddToAllMoviesEvent) {
      yield* _mapAddToAllMovies(event);
    }
    else if (event is LoadMoviesEvent) {
      yield* _mapLoadMovies(event);
    }
  }

  Stream<MoviesState> _mapAddToFavorites(AddToFavoritesEvent event) async* {
    final List<MovieModel> updatedFavorites = List.from(state.favoritesList)
      ..add(event.newMovie);
    yield MoviesLoaded(updatedFavorites, state.allMoviesList);
  }

  Stream<MoviesState> _mapRemoveFromFavorites(RemoveFromFavoritesEvent event) async* {
    final List<MovieModel> updatedFavorites = List.from(state.favoritesList)
      ..remove(event.oldMovie);
    yield MoviesLoaded(updatedFavorites, state.allMoviesList);
  }

  Stream<MoviesState> _mapAddToAllMovies(AddToAllMoviesEvent event) async* {
    final List<MovieModel> updatedMovies = List.from(state.allMoviesList)..add(event.newMovie);
    yield MoviesLoaded(state.favoritesList, updatedMovies);
  }

  Stream<MoviesState> _mapLoadMovies(LoadMoviesEvent event) async* {
    yield MoviesLoading(state.favoritesList, state.allMoviesList);
    try {
      loadMovies(event.context);
      yield MoviesLoaded(state.favoritesList, state.allMoviesList);
    } catch (e) {
      yield MoviesError(state.favoritesList, state.allMoviesList);
    }
  }
}