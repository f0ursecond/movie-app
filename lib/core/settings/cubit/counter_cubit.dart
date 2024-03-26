import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(const CounterState(value: 0));

  void increment() {
    emit(CounterState(value: state.value + 1, isIncrement: true));
  }

  void decrement() {
    emit(CounterState(value: state.value < 0 ? 0 : -1, isIncrement: false));
  }
}
