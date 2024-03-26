part of 'discover_movie_bloc.dart';

sealed class DiscoverEventState extends Equatable {
  const DiscoverEventState();

  @override
  List<Object> get props => [];
}

class GetMovieDiscover extends DiscoverEventState {}
