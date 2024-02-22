import 'package:dio/dio.dart';
import 'package:movie_app/core/network/network_repository.dart';
import 'package:movie_app/data/exception/api_exception.dart';
import 'package:movie_app/data/model/movie.dart';
import 'package:movie_app/data/model/trailer.dart';
import 'package:movie_app/utils/constants.dart';

class NetworkRepositoryImpl implements NetworkRepository {
  final Dio _dio;
  final String _base_url;
  NetworkRepositoryImpl(this._dio, this._base_url);
  @override
  Future<MovieApiResModel> fetchUpComingMovie(String path) async {
    try {
      Response response = await _dio.get(
        "$_base_url/$path",
        queryParameters: {"api_key": api_key},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MovieApiResModel.fromJson(response.data);
      } else {
        throw ApiException(response.statusCode, response.statusMessage);
      }
    } catch (e) {
      throw ApiException(500, "Internal Server Error");
    }
  }

  @override
  Future<MovieApiResModel> searchMovie(String query) async {
    try {
      Response response = await _dio.get(
        "https://api.themoviedb.org/3/search/movie",
        queryParameters: {
          "api_key": api_key,
          "query": query,
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return MovieApiResModel.fromJson(response.data);
      } else {
        throw ApiException(response.statusCode, response.statusMessage);
      }
    } catch (e) {
      throw ApiException(500, "Internal Server Error");
    }
  }

  @override
  Future<TrailerApiResModel> fetchMovieTrailer(int movieId) async {
    try {
      Response response = await _dio.get(
        "$base_url/$movieId/videos",
        queryParameters: {
          "api_key": api_key,
          "language": "en-US",
        },
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        return TrailerApiResModel.fromJson(response.data);
      } else {
        throw ApiException(response.statusCode, response.statusMessage);
      }
    } catch (e) {
      throw ApiException(500, "Internal Server Error");
    }
  }
}
