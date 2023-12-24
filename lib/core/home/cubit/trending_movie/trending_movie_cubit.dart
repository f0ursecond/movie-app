import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/models/res_movie.dart';
import 'package:movie_app/core/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

part 'trending_movie_state.dart';

class TrendingMovieCubit extends Cubit<TrendingMovieState> {
  TrendingMovieCubit() : super(TrendingMovieInitial());

  final repo = MovieRepository();

  Future<void> getTrendingMovie() async {
    emit(TrendingMovieLoading());

    final result = await repo.getTrendingMovie();
    result.fold(
      (l) => emit(TrendingMovieFailure(failure: l)),
      (r) => emit(TrendingMovieSuccess(result: r)),
    );
  }
}
