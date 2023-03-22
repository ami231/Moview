import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/bloc/movies_event.dart';
import 'package:moview/constants/api.dart';
import 'package:moview/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../bloc/movies_bloc.dart';

void loadFavorites(context) async {
  final moviesBloc = BlocProvider.of<MoviesBloc>(context);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteStrings = prefs.getStringList(localList) ?? [];
  List mapList = favoriteStrings.map((item) => jsonDecode(item)).toList();
  for (var element in mapList) {
    Map<String, dynamic> decodedJson = jsonDecode(element);
    MovieModel movie = MovieModel.fromJson(decodedJson);
    moviesBloc.add(AddToFavoritesEvent(movie));
  }
  print(moviesBloc.state.favoritesList);
}