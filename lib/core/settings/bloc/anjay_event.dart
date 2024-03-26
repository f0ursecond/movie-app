part of 'anjay_bloc.dart';

sealed class AnjayEvent extends Equatable {
  const AnjayEvent();

  @override
  List<Object> get props => [];
}

class IncrementEvent extends AnjayEvent {}

class DecrementEvent extends AnjayEvent {}
