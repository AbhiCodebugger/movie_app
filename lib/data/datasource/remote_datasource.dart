import 'package:movie_app/core/network/network_repository.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/model/trailer.dart';

class RemoteDataSource {
  final NetworkRepository _networkRepository;
  RemoteDataSource(this._networkRepository);

  Future<MovieApiResModel> fetchMovie(String path) async {
    return _networkRepository.fetchUpComingMovie(path);
  }

  Future<MovieApiResModel> searchMovie(String query) async {
    return await _networkRepository.searchMovie(query);
  }

  Future<TrailerApiResModel> fetchTrailer(int movieId) async {
    return await _networkRepository.fetchMovieTrailer(movieId);
  }
}
