import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/model/trailer.dart';

abstract class NetworkRepository {
  Future<MovieApiResModel> fetchUpComingMovie(String path);

  Future<MovieApiResModel> searchMovie(String query);

  Future<TrailerApiResModel> fetchMovieTrailer(int movieId);
}
