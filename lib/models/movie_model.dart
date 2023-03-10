class MovieModel {
  final String title;
  final int id;
  final String releaseDate;
  final String posterPath;
  final double rating;
  final String overview;

  MovieModel(
      {required this.title,
      required this.id,
      required this.releaseDate,
      required this.posterPath,
      required this.rating,
      required this.overview});

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      title: json['title'],
      id: json['id'],
      releaseDate: json['release_date'],
      posterPath: json['poster_path'],
      rating: json['vote_average'].toDouble(),
      overview: json['overview'],
    );
  }
}
