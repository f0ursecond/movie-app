part of 'discover_movie_bloc.dart';

sealed class DiscoverMovieState extends Equatable {
  const DiscoverMovieState();

  @override
  List<Object> get props => [];
}

final class DiscoverInitial extends DiscoverMovieState {}

final class DiscoverLoading extends DiscoverMovieState {}

final class DiscoverSuccess extends DiscoverMovieState {
  DiscoverSuccess({required this.result});
  final List<ResMovie> result;
}

final class DiscoverFailure extends DiscoverMovieState {
  DiscoverFailure({required this.failure});
  final Failure failure;
}
