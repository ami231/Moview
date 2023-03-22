import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/bloc/cubit.dart';
import 'package:moview/bloc/movies_event.dart';
import '../bloc/movies_bloc.dart';
import '../constants/api.dart';
import '../models/movie_model.dart';


Future<Response> fetchApiData(context) async {
  final dio = Dio();
  final page = BlocProvider.of<PageCubit>(context).state.page;
  final response = await dio.get('$apiUrl$apiKey$apiInfo$page');
  return response;
}

Future<List<MovieModel>> loadMovies(response, context) async {
  List<MovieModel> moviesList = [];
  final moviesBloc = BlocProvider.of<MoviesBloc>(context);
  await response.data['results'].forEach((element) {
    final movie = MovieModel.fromJson(element);
    moviesList.add(movie);
    //moviesBloc.add(AddToAllMoviesEvent(movie));
  });
  int maxPage = await response.data['total_pages'];
  BlocProvider.of<MaxPageCubit>(context).updateMaxPage(maxPage);
  return moviesList;
}

