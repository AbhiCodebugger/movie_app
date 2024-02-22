import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class SearchMovieUseCase {
  final MovieRepository repository;
  SearchMovieUseCase(this.repository);
  Future<List<MovieEntity>> searchMovie(String query) async {
    return await repository.searchMovie(query);
  }
}
