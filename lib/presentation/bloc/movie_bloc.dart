import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:movie_app/data/exception/api_exception.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/usecase/movie_usecase.dart';

part 'movie_event.dart';
part 'movie_state.dart';

class MovieBloc extends Bloc<MovieEvent, MovieState> {
  final MovieUseCase movieUseCase;
  MovieBloc(this.movieUseCase) : super(MovieInitial()) {
    on<FetchUpComingMovies>(_onFetchMovie);
  }

  _onFetchMovie(FetchUpComingMovies event, Emitter emit) async {
    emit(MovieLoading());
    try {
      final movies = await movieUseCase.fetchUpComingMovie();
      emit(MovieLoaded(movies));
    } catch (e) {
      if (e is ApiException) {
        emit(MovieError("Error : ${e.statusCode} ${e.responseData}"));
      } else {
        emit(MovieError("An unexpected error occured. Please try again"));
      }
    }
  }
}
