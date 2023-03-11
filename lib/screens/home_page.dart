import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:moview/constants/api.dart';
import 'package:moview/models/movie_model.dart';
import 'package:moview/controllers/movies_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({Key? key}) : super(key: key);

  void loadMovies() async {
    final dio = Dio();

    final response = await dio.get('$apiUrl$apiKey$apiInfo$apiPage');
    if (response.statusCode == 200) {
      response.data['results'].forEach((element) {
        final movie = MovieModel.fromJson(element);
        movieList.add(movie);
        print(movie.id);
      });
    }
  }

  void initState() {
    loadMovies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular movies'),
      ),
      body: Center(
        child: Column(
          children: [
            TextButton(
              onPressed: () {
                loadMovies();
              },
              child: const Text('Get data'),
            ),
            if (movieList.isNotEmpty)
              ListView.builder(
                itemCount: movieList.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: const Icon(Icons.list),
                    trailing: const Text('movieee'),
                    title: Text(movieList[index].title),
                  );
                },
              )
          ],
        ),
      ),
    );
  }
}
