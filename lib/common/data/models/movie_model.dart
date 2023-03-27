import 'dart:convert';

class MovieModel {
  final String title;
  final int id;
  final String releaseDate;
  final String posterPath;
  final double rating;
  final String overview;
  final List<int> genreIds;


  MovieModel({
    required this.title,
    required this.id,
    required this.releaseDate,
    required this.posterPath,
    required this.rating,
    required this.overview,
    required this.genreIds,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      id: json['id'],
      releaseDate: json['release_date'] as String,
      posterPath: json['poster_path'],
      rating: json['vote_average'].toDouble(),
      overview: json['overview'],
      genreIds: json['genre_ids'].cast<int>(),
    );
  }

  Map<String, dynamic> toJson() => {
        'title': title,
        'id': id,
        'release_date': releaseDate,
        'poster_path': posterPath,
        'rating': rating,
        'overview': overview,
        'genre_ids': genreIds,
      };
}
