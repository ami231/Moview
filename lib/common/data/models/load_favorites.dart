import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/common/domain/bloc/movies_event.dart';
import 'package:moview/common/data/constants/api.dart';
import 'package:moview/common/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/bloc/movies_bloc.dart';

void loadFavorites(context) async {
  final moviesBloc = BlocProvider.of<MoviesBloc>(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteStrings = prefs.getStringList(localFavoriteList) ?? [];
  for (var element in favoriteStrings) {
    try {
      Map<String, dynamic> decodedJson = jsonDecode(element);
      MovieModel movie = MovieModel.fromJson(decodedJson);
      moviesBloc.add(AddToFavoritesEvent(movie));
    } catch (e) {
      //print(e);
    }

  }
}
