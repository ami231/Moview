import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/data/constants/api.dart';
import '../../../../common/data/models/movie_model.dart';
import '../../../../common/domain/bloc/movies_state.dart';
import '../pages/movie_detail_page.dart';
import 'movie_listview_widget.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({
    Key? key,
    required this.posterPath,
    required this.movie,
    required this.title,
    required this.releaseDate,
    required this.state
  }) : super(key: key);

  final String posterPath;
  final MovieModel movie;
  final String title;
  final DateTime releaseDate;
  final MoviesState state;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(5)),
        child: Image.network("$posterUrl$posterPath"),
      ),
      trailing: IconButton(
        onPressed: () {
          favoriteAction(state: state, movie: movie, context: context);
        },
        icon: isFavorite(movieId: movie.id, favoritesList: state.favoritesList) == true
            ? const Icon(
          CupertinoIcons.heart_fill,
          color: Colors.purpleAccent,
        )
            : const Icon(CupertinoIcons.heart),
      ),
      title: Text(title),
      subtitle: Text('${releaseDate.day}.${releaseDate.month}.${releaseDate.year}'),
      onTap: () {
        Navigator.pushNamed(context, MovieDetailPage.title, arguments: movie);
      },
    );
  }
}

bool isFavorite({movieId, favoritesList}) {
  bool isFavorite = false;
  for (MovieModel movie in favoritesList) {
    if (movieId == movie.id) {
      isFavorite = true;
    }
  }
  return isFavorite;
}