part of 'movie_trailer_bloc.dart';

sealed class MovieTrailerEvent extends Equatable {
  const MovieTrailerEvent();

  @override
  List<Object> get props => [];
}

final class FetchMovieTrailer extends MovieTrailerEvent {
  final int movieId;
  const FetchMovieTrailer(this.movieId);

  @override
  List<Object> get props => [movieId];
}

final class WatchMovieTrailer extends MovieTrailerEvent {
  final String movieId;

  const WatchMovieTrailer(this.movieId);
  @override
  List<Object> get props => [movieId];
}
