import 'package:movie_app/domain/entity/trailer_entity.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class TrailerUseCase {
  final MovieRepository _repository;

  TrailerUseCase(this._repository);

  Future<List<TrailerEntity>> fetchMovieTrailer(int movieId) async {
    return await _repository.fetchMovieTrailer(movieId);
  }
}
