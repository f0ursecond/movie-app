part of 'discover_movie_cubit.dart';

sealed class DiscoverMovieState extends Equatable {
  const DiscoverMovieState();

  @override
  List<Object> get props => [];
}

final class DiscoverMovieInitial extends DiscoverMovieState {}

final class DiscoverMovieLoading extends DiscoverMovieState {}

final class DiscoverMovieSuccess extends DiscoverMovieState {
  DiscoverMovieSuccess({required this.result}) : super();
  final List<ResMovie> result;
}

final class DiscoverMovieFailure extends DiscoverMovieState {
  const DiscoverMovieFailure({required this.failure}) : super();

  final Failure failure;
}
