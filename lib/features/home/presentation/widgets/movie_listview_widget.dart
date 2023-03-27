import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/common/data/models/update_favorites_storage.dart';
import '../../domain/page_cubit.dart';
import '../../../../common/domain/bloc/movies_bloc.dart';
import '../../../../common/domain/bloc/movies_event.dart';
import '../../../../common/domain/bloc/movies_state.dart';
import '../../domain/scroll_cubit.dart';
import '../../../../common/data/models/movie_model.dart';
import 'movie_tile_widget.dart';

BlocBuilder<ScrollControllerCubit, ScrollController> buildMovieListView(
    {required MoviesState state, required List<MovieModel> list, required int length, required bool isHomePage,
      required BuildContext context}) {
  final scrollController = context.watch<ScrollControllerCubit>();

  scrollController.state.addListener(() {
    if (scrollController.state.position.pixels ==
        scrollController.state.position.maxScrollExtent) {
      BlocProvider.of<PageCubit>(context).nextPage();
      BlocProvider.of<MoviesBloc>(context).add(LoadMoviesEvent(context));
    }
  });

  return BlocBuilder<ScrollControllerCubit, ScrollController>(
    builder: (context, scrollController) {
      return BlocBuilder<MoviesBloc, MoviesState>(
        builder: (context, state) {
          return ListView.separated(
            controller: isHomePage ? scrollController : null,
            separatorBuilder: (context, index) => const Divider(
              thickness: 1.5,
              color: Colors.black,
            ),
            itemCount: length,
            itemBuilder: (BuildContext context, int index) {
                final movie = list[index];
                final posterPath = movie.posterPath;
                final title = movie.title;
                final releaseDate = DateTime.parse(movie.releaseDate);
                return MovieTile(posterPath: posterPath, movie: movie, title: title, releaseDate: releaseDate, state: state,);
            },
          );
        }
      );
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
