import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/exception/api_exception.dart';
import 'package:movie_app/domain/entity/trailer_entity.dart';
import 'package:movie_app/domain/usecase/trailer_usecase.dart';

part 'movie_trailer_event.dart';
part 'movie_trailer_state.dart';

class MovieTrailerBloc extends Bloc<MovieTrailerEvent, MovieTrailerState> {
  TrailerUseCase trailerUseCase;
  MovieTrailerBloc(this.trailerUseCase) : super(MovieTrailerInitial()) {
    on<FetchMovieTrailer>(_onFetchMovieTrailer);
  }

  _onFetchMovieTrailer(FetchMovieTrailer event, Emitter emit) async {
    emit(MovieTrailerLoading());
    try {
      final movieTrailer =
          await trailerUseCase.fetchMovieTrailer(event.movieId);
      emit(MovieTrailerLoaded(movieTrailer));
    } catch (e) {
      if (e is ApiException) {
        emit(MovieTrailerError("Error : ${e.statusCode} ${e.responseData}"));
      } else {
        emit(const MovieTrailerError(
            "An unexpected error occured. Please try again"));
      }
    }
  }
}
