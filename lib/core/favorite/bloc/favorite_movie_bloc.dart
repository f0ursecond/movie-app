import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/models/res_movie.dart';
import 'package:movie_app/core/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

part 'favorite_movie_event.dart';
part 'favorite_movie_state.dart';

class FavoriteMovieBloc extends Bloc<FavoriteMovieEvent, FavoriteMovieState> {
  FavoriteMovieBloc() : super(FavoriteMovieInitial()) {
    final repo = MovieRepository();

    on<GetFavoriteMovie>((event, emit) async {
      try {
        emit(FavoriteMovieLoading());

        final result = await repo.getFavoriteMovie();
        result.fold(
          (l) => emit(FavoriteMovieFailure(failure: l)),
          (r) => emit(FavoriteMovieSuccess(result: r)),
        );
      } on DioException catch (e) {
        emit(FavoriteMovieFailure(failure: ServerFailure(message: e.message.toString())));
      } catch (e) {
        emit(
          FavoriteMovieFailure(failure: ServerFailure(message: e.toString())),
        );
      }
    });
  }
}
