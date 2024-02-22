import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/entity/trailer_entity.dart';

abstract class MovieRepository {
  Future<List<MovieEntity>> fetchUpComingMovie();

  Future<List<MovieEntity>> searchMovie(String query);

  Future<List<TrailerEntity>> fetchMovieTrailer(int movieId);
}
