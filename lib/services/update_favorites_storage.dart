import 'dart:convert';

import 'package:moview/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moview/constants/api.dart';

Future<void> addItemToList(MovieModel newMovie) async {
  final movieString = jsonEncode(newMovie.toJson());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteStrings = prefs.getStringList(localList) ?? [];
  favoriteStrings.add(movieString);
  await prefs.setStringList(localList, favoriteStrings);
}

Future<void> removeItemFromList(MovieModel movieToRemove) async {
  final movieString = jsonEncode(movieToRemove.toJson());
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteStrings = prefs.getStringList(localList) ?? [];
  favoriteStrings.remove(movieString);
  await prefs.setStringList(localList, favoriteStrings);
}