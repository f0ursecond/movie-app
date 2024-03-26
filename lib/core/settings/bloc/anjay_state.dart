part of 'anjay_bloc.dart';

class AnjayState extends Equatable {
  final int initialValue;
  const AnjayState(this.initialValue);

  @override
  List<Object?> get props => [initialValue];
}
