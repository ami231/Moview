import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/bloc/cubit.dart';
import 'package:moview/bloc/movies_event.dart';
import '../bloc/movies_bloc.dart';
import '../constants/api.dart';
import '../models/movie_model.dart';

void loadMovies(context) async {
  final dio = Dio();
  final favoritesBloc = BlocProvider.of<MoviesBloc>(context);
  final page = BlocProvider.of<PageCubit>(context).state.page;
  final response = await dio.get('$apiUrl$apiKey$apiInfo$page');
  if (response.statusCode == 200) {
    await response.data['results'].forEach((element) {
      final movie = MovieModel.fromJson(element);
      favoritesBloc.add(AddToAllMoviesEvent(movie));
    });
    int maxPage = await response.data['total_pages'];
    BlocProvider.of<MaxPageCubit>(context).updateMaxPage(maxPage);
  }
}