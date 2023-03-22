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
    yield MoviesLoading();
    final response = await fetchApiData(event.context);
    if (response.statusCode == 200) {
      try {
        final movieList = await loadMovies(response, event.context);
        yield MoviesLoaded(state.favoritesList, movieList);
        print('from bloc');
        print(state.allMoviesList);
      } catch (_) {
        yield MoviesError();
      }
    }
    else if (response.statusCode == 404) {
      yield MoviesError();

    }
  }
}