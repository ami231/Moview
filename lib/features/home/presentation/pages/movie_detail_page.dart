import 'package:flutter/material.dart';
import 'package:moview/common/data/constants/api.dart';
import 'package:moview/common/data/models/movie_model.dart';

class MovieDetailPage extends StatefulWidget {
  static const String title = 'MovieDetailPage';

  const MovieDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  Widget build(BuildContext context) {
    final MovieModel movie = ModalRoute.of(context)?.settings.arguments as MovieModel;
    final posterPath = movie.posterPath;
    final title = movie.title;
    final rating = movie.rating.toString();
    final overview = movie.overview;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.only(bottom: 200, left: 20, right: 20, top: 30),
        child: Wrap(
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Text(
                        title,
                        style: const TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      child: Image.network(
                        "$posterUrl$posterPath",
                        height: 200,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text(
                            'Rating: ',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          Text(
                            rating,
                            style: const TextStyle(fontSize: 14),
                          )
                        ]),
                        const Padding(
                          padding: EdgeInsets.only(top: 10.0),
                          child: Text(
                            'Overview:',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 5.0),
                          child: Text(overview),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
