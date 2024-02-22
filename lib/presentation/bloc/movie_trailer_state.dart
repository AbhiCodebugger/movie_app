part of 'movie_trailer_bloc.dart';

sealed class MovieTrailerState extends Equatable {
  const MovieTrailerState();

  @override
  List<Object> get props => [];
}

final class MovieTrailerInitial extends MovieTrailerState {}

final class MovieTrailerLoaded extends MovieTrailerState {
  final List<TrailerEntity> trailer;
  const MovieTrailerLoaded(this.trailer);

  @override
  List<Object> get props => [trailer];
}

final class MovieTrailerError extends MovieTrailerState {
  final String error;
  const MovieTrailerError(this.error);
  @override
  List<Object> get props => [error];
}

final class MovieTrailerLoading extends MovieTrailerState {}
