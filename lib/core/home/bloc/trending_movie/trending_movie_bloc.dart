import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/models/res_movie.dart';
import 'package:movie_app/core/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

part 'trending_movie_event.dart';
part 'trending_movie_state.dart';

class TrendingMovieBloc extends Bloc<TrendingMovieEvent, TrendingMovieState> {
  TrendingMovieBloc() : super(TrendingMovieInitial()) {
    on<GetTrendingMovie>((event, emit) async {
      final repo = MovieRepository();
      try {
        emit(TrendingMovieLoading());
        final result = await repo.getTrendingMovie();
        result.fold(
          (l) => emit(TrendingMovieFailure(failure: l)),
          (r) => emit(TrendingMovieSuccess(result: r)),
        );
      } on DioException catch (e) {
        emit(TrendingMovieFailure(
          failure: ServerFailure(message: 'cuy ${e.type.name}'),
        ));
      } catch (e) {
        emit(TrendingMovieFailure(
          failure: ServerFailure(message: e.toString()),
        ));
      }
    });
  }
}
