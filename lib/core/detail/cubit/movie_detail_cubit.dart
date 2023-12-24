import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/models/res_movie_detail.dart';
import 'package:movie_app/core/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  MovieDetailCubit() : super(MovieDetailInitial());

  final repo = MovieRepository();

  Future<void> getMovieDetail(String movieId) async {
    emit(MovieDetailLoading());

    final result = await repo.getMovieDetail(movieId);
    result.fold(
      (l) => emit(MovieDetailFailure(failure: l)),
      (r) => emit(MovieDetailSuccess(result: r)),
    );
  }
}
