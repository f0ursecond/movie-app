part of 'add_favorite_bloc.dart';

sealed class AddFavoriteState extends Equatable {
  const AddFavoriteState();

  @override
  List<Object> get props => [];
}

final class AddFavoriteInitial extends AddFavoriteState {}

final class AddFavoriteLoading extends AddFavoriteState {}

final class AddFavoriteSuccess extends AddFavoriteState {
  const AddFavoriteSuccess({required this.result});
  final ResAddFavorite result;
}

final class AddFavoriteFailure extends AddFavoriteState {
  const AddFavoriteFailure({required this.failure});
  final Failure failure;
}
