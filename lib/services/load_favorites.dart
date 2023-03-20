import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/bloc/movies_event.dart';
import 'package:moview/constants/api.dart';
import 'package:moview/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/movies_bloc.dart';

void loadFavorites(context) async {
  final favoritesBloc = BlocProvider.of<MoviesBloc>(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteStrings = prefs.getStringList(localList) ?? [];
  for (var element in favoriteStrings) {
    MovieModel movie = MovieModel.fromJson(jsonDecode(element));
    favoritesBloc.add(AddToFavoritesEvent(movie));
  }
}