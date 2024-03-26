part of 'trending_movie_bloc.dart';

sealed class TrendingMovieEvent extends Equatable {
  const TrendingMovieEvent();

  @override
  List<Object> get props => [];
}

class GetTrendingMovie extends TrendingMovieEvent {}
