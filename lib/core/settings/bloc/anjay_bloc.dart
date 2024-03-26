import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anjay_event.dart';
part 'anjay_state.dart';

class AnjayBloc extends Bloc<AnjayEvent, AnjayState> {
  AnjayBloc() : super(const AnjayState(0)) {
    on<IncrementEvent>((event, emit) {
      emit(AnjayState(state.initialValue + 1));
    });

    on<DecrementEvent>((event, emit) {
      if (state.initialValue > 0) {
        emit(AnjayState(state.initialValue - 1));
      } else {
        0;
      }
    });
  }
}
