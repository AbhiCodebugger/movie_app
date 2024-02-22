part of 'movie_bloc.dart';

@immutable
sealed class MovieState extends Equatable {
  @override
  List<Object> get props => [];
}

final class MovieInitial extends MovieState {}

class MovieLoading extends MovieState {}

class MovieLoaded extends MovieState {
  final List<MovieEntity> upcomingMovies;

  MovieLoaded(this.upcomingMovies);

  @override
  List<Object> get props => [upcomingMovies];
}

class MovieError extends MovieState {
  final String message;

  MovieError(this.message);

  @override
  List<Object> get props => [message];
}
