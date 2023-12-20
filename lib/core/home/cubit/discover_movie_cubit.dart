import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/home/models/res_movie.dart';
import 'package:movie_app/core/home/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

part 'discover_movie_state.dart';

class DiscoverMovieCubit extends Cubit<DiscoverMovieState> {
  DiscoverMovieCubit() : super(DiscoverMovieInitial());

  final repo = MovieRepository();

  Future<void> getMovieDiscover() async {
    emit(DiscoverMovieLoading());

    final result = await repo.getMovieDiscover();
    result.fold(
      (l) => emit(DiscoverMovieFailure(failure: l)),
      (r) => emit(DiscoverMovieSuccess(result: r)),
    );
  }
}
