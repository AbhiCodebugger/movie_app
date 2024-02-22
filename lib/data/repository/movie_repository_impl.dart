import 'package:movie_app/core/network/network_repository.dart';
import 'package:movie_app/data/mapper/movie_mapper.dart';
import 'package:movie_app/data/mapper/trailer_mapping.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/model/trailer.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/entity/trailer_entity.dart';
import 'package:movie_app/domain/repository/movie_repository.dart';

class MovieRepositoryImpl implements MovieRepository {
  final NetworkRepository _networkRepository;
  MovieRepositoryImpl(this._networkRepository);
  @override
  Future<List<MovieEntity>> fetchUpComingMovie() async {
    try {
      MovieApiResModel movieApiResModel =
          await _networkRepository.fetchUpComingMovie("upcoming");
      List<Results> results = movieApiResModel.results ?? [];
      return results.map((e) => MovieMapper().convert(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<MovieEntity>> searchMovie(String query) async {
    try {
      MovieApiResModel model = await _networkRepository.searchMovie(query);
      List<Results> results = model.results ?? [];
      return results.map((e) => MovieMapper().convert(e)).toList();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TrailerEntity>> fetchMovieTrailer(int movieId) async {
    try {
      TrailerApiResModel model =
          await _networkRepository.fetchMovieTrailer(movieId);
      List<Trailer> results = model.trailer ?? [];
      return results.map((e) => TrailerMapping().convert(e)).toList();
    } catch (e) {
      rethrow;
    }
  }
}
