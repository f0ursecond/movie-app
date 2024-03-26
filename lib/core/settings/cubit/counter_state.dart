part of 'counter_cubit.dart';

class CounterState extends Equatable {
  final int value;
  final bool? isIncrement;
  const CounterState({required this.value, this.isIncrement});

  @override
  List<Object?> get props => [value, isIncrement];
}
