import 'package:moview/common/data/models/movie_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:moview/common/data/constants/api.dart';

Future<void> addItemToList(MovieModel newMovie) async {
  final movieString = newMovie.toJson().toString();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var favoriteStrings = prefs.getStringList(localFavoriteList) ?? [];
  favoriteStrings.add(movieString);
  await prefs.setStringList(localFavoriteList, favoriteStrings);
}

Future<void> removeItemFromList(MovieModel movieToRemove) async {
  final movieString = movieToRemove.toJson().toString();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<String> favoriteStrings = prefs.getStringList(localFavoriteList) ?? [];
  favoriteStrings.remove(movieString);
  await prefs.setStringList(localFavoriteList, favoriteStrings);
}
