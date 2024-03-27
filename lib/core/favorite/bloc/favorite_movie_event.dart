part of 'favorite_movie_bloc.dart';

sealed class FavoriteMovieEvent extends Equatable {
  const FavoriteMovieEvent();

  @override
  List<Object> get props => [];
}

class GetFavoriteMovie extends FavoriteMovieEvent {}
