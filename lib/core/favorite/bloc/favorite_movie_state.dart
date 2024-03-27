part of 'favorite_movie_bloc.dart';

sealed class FavoriteMovieState extends Equatable {
  const FavoriteMovieState();

  @override
  List<Object> get props => [];
}

final class FavoriteMovieInitial extends FavoriteMovieState {}

final class FavoriteMovieLoading extends FavoriteMovieState {}

final class FavoriteMovieSuccess extends FavoriteMovieState {
  final List<ResMovie> result;

  const FavoriteMovieSuccess({required this.result});
}

final class FavoriteMovieFailure extends FavoriteMovieState {
  final Failure failure;
  const FavoriteMovieFailure({required this.failure});
}
