part of 'trending_movie_cubit.dart';

sealed class TrendingMovieState extends Equatable {
  const TrendingMovieState();

  @override
  List<Object> get props => [];
}

final class TrendingMovieInitial extends TrendingMovieState {}

final class TrendingMovieLoading extends TrendingMovieState {}

final class TrendingMovieSuccess extends TrendingMovieState {
  const TrendingMovieSuccess({required this.result}) : super();
  final List<ResMovie> result;
}

final class TrendingMovieFailure extends TrendingMovieState {
  const TrendingMovieFailure({required this.failure}) : super();
  final Failure failure;
}
