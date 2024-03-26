import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/core/models/res_movie.dart';
import 'package:movie_app/core/repositories/movie_repository.dart';
import 'package:movie_app/utils/failure.dart';

part 'discover_movie_event.dart';
part 'discover_movie_state.dart';

class DiscoverMovieBloc extends Bloc<DiscoverEventState, DiscoverMovieState> {
  DiscoverMovieBloc() : super(DiscoverInitial()) {
    final repo = MovieRepository();

    on<GetMovieDiscover>((event, emit) async {
      try {
        emit(DiscoverLoading());
        final result = await repo.getMovieDiscover();
        result.fold(
          (l) {
            emit(DiscoverFailure(failure: l));
          },
          (r) => emit(DiscoverSuccess(result: r)),
        );
      } on DioException catch (e) {
        emit(DiscoverFailure(
          failure: ServerFailure(message: 'cuy ${e.type.name}'),
        ));
      } catch (e) {
        emit(DiscoverFailure(
          failure: ServerFailure(message: 'oke ${e.toString()}'),
        ));
      }
    });
  }
}
