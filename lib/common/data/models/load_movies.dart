import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:moview/features/home/domain/page_cubit.dart';
import '../../domain/bloc/movies_bloc.dart';
import '../../domain/bloc/movies_event.dart';
import '../constants/api.dart';
import 'movie_model.dart';


Future<Response> fetchApiData(context) async {
  final dio = Dio();
  final page = BlocProvider.of<PageCubit>(context).state.page;
  final response = await dio.get('$apiUrl$apiKey$apiInfo$page');
  return response;
}

Future<List<MovieModel>> loadMovies(response, context) async {
  List<MovieModel> moviesList = [];
  await response.data['results'].forEach((element) {
    try{
      final movie = MovieModel.fromJson(element);
      moviesList.add(movie);
    } catch (_) {}
  });
  return moviesList;
}


