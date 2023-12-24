part of 'movie_detail_cubit.dart';

sealed class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailSuccess extends MovieDetailState {
  const MovieDetailSuccess({required this.result}) : super();
  final ResMovieDetail result;
}

final class MovieDetailFailure extends MovieDetailState {
  const MovieDetailFailure({required this.failure}) : super();
  final Failure failure;
}
