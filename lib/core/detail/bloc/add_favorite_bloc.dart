import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/detail/models/res_add_favorite.dart';
import 'package:movie_app/core/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

part 'add_favorite_event.dart';
part 'add_favorite_state.dart';

class AddFavoriteBloc extends Bloc<AddFavoriteEvent, AddFavoriteState> {
  AddFavoriteBloc() : super(AddFavoriteInitial()) {
    final movieRepository = MovieRepository();

    on<AddFavoriteEvent>((event, emit) async {
      if (event is ResetAddFavoriteMovie) {
        emit(AddFavoriteInitial());
        return;
      }

      try {
        emit(AddFavoriteLoading());
        if (event is AddFavoriteMovie) {
          final result = await movieRepository.postFavoriteMovie(event.movieId);
          result.fold(
            (l) => emit(AddFavoriteFailure(failure: l)),
            (r) => emit(AddFavoriteSuccess(result: r)),
          );
        }
      } on DioException catch (e) {
        emit(AddFavoriteFailure(
          failure: ServerFailure(message: 'cuy ${e.type.name}'),
        ));
      } catch (e) {
        emit(AddFavoriteFailure(
          failure: ServerFailure(message: 'gagal $e'),
        ));
      }
    });
  }
}
