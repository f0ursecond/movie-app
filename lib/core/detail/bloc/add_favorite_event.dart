part of 'add_favorite_bloc.dart';

sealed class AddFavoriteEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ResetAddFavoriteMovie extends AddFavoriteEvent {
  @override
  List<Object> get props => [];
}

class AddFavoriteMovie extends AddFavoriteEvent {
  final String movieId;
  AddFavoriteMovie(this.movieId);

  @override
  List<Object> get props => [movieId];
}
