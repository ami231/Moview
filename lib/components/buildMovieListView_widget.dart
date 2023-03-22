import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/services/update_favorites_storage.dart';
import '../bloc/cubit.dart';
import '../bloc/movies_bloc.dart';
import '../bloc/movies_event.dart';
import '../bloc/movies_state.dart';
import '../constants/api.dart';
import '../models/movie_model.dart';

ListView buildMovieListView(
    {required MoviesState state, required List<MovieModel> list, required int length, required bool isHomePage}) {
  return ListView.separated(
    separatorBuilder: (context, index) => const Divider(
      thickness: 1.5,
      color: Colors.black,
    ),
    itemCount: length + 1,
    itemBuilder: (BuildContext context, int index) {
      if (index != length) {
        final movie = list[index];
        final posterPath = movie.posterPath;
        final title = movie.title;
        final releaseDate = DateTime.parse(movie.releaseDate);
        return ListTile(
          leading: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(5)),
            child: Image.network("$posterUrl$posterPath"),
          ),
          trailing: IconButton(
            onPressed: () {
              favoriteAction(state: state, movie: movie, context: context);
            },
            icon: isFavorite(movieId: movie.id, favoritesList: state.favoritesList)
                ? const Icon(
                    CupertinoIcons.heart_fill,
                    color: Colors.purpleAccent,
                  )
                : const Icon(CupertinoIcons.heart),
          ),
          title: Text(title),
          subtitle: Text('${releaseDate.day}.${releaseDate.month}.${releaseDate.year}'),
          onTap: () {
            Navigator.pushNamed(context, '/MovieDetailPage', arguments: movie);
          },
        );
      } else if (isHomePage && list.isNotEmpty) {
        return TextButton(
          onPressed: () {
            BlocProvider.of<PageCubit>(context).nextPage();
            BlocProvider.of<MoviesBloc>(context).add(LoadMoviesEvent(context));
          },
          child: const Text(
            'Load more',
            style: TextStyle(color: Colors.purpleAccent),
          ),
        );
      }
    },
  );
}

void favoriteAction({state, movie, context}) {
  if (!state.favoritesList.contains(movie)) {
    BlocProvider.of<MoviesBloc>(context).add(AddToFavoritesEvent(movie));
    addItemToList(movie);
  } else {
    BlocProvider.of<MoviesBloc>(context).add(RemoveFromFavoritesEvent(movie));
    removeItemFromList(movie);
  }
}

bool isFavorite({movieId, favoritesList}) {
  for (MovieModel movie in favoritesList) {
    if (movieId == movie.id) {
      return true;
    }
  }
  return false;
}
