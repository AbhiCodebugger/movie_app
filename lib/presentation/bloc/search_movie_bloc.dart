import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/data/exception/api_exception.dart';
import 'package:movie_app/domain/entity/movie_entity.dart';
import 'package:movie_app/domain/usecase/search_movie_usecase.dart';

part 'search_movie_event.dart';
part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  SearchMovieUseCase useCase;
  SearchMovieBloc(this.useCase) : super(SearchMovieInitial()) {
    on<SearchMovie>(_onSearchMovie);
  }

  _onSearchMovie(SearchMovie event, Emitter emit) async {
    emit(SearchMovieLoading());
    try {
      final searchedMovie = await useCase.searchMovie(event.query);
      emit(SearchMovieLoaded(searchedMovie));
    } catch (e) {
      if (e is ApiException) {
        emit(SearchMovieError("Error : ${e.statusCode} ${e.responseData}"));
      } else {
        emit(const SearchMovieError(
            "An unexpected error occured. Please try again"));
      }
    }
  }
}
