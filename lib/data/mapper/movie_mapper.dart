import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';

class MovieMapper {
  MovieEntity convert(Results category) {
    return MovieEntity(
        movieId: category.id ?? 0,
        title: category.title ?? "",
        description: category.overview ?? "",
        rating: category.voteAverage ?? 0.0,
        image: category.posterPath ?? "",
        isAdult: category.adult ?? false);
  }
}
