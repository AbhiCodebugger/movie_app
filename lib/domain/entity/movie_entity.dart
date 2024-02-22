class MovieEntity {
  int movieId;
  String title;
  String description;
  double rating;
  String image;
  bool isAdult;
  String releaseDate;

  MovieEntity({
    required this.movieId,
    required this.title,
    required this.description,
    required this.rating,
    required this.image,
    required this.isAdult,
    required this.releaseDate,
  });
}
