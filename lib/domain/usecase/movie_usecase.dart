import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class MovieUseCase {
  final MovieRepository repository;
  MovieUseCase(this.repository);

  Future<List<MovieEntity>> fetchUpComingMovie() async {
    return await repository.fetchUpComingMovie();
  }
}
