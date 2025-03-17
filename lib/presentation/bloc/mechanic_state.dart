part of 'mechanic_bloc.dart';

@immutable
abstract class MechanicState {}

class MechanicInitial extends MechanicState {}

class MechanicLoading extends MechanicState {}

class MechanicLoaded extends MechanicState {
  final List<Mechanic> mechanics;

  MechanicLoaded(this.mechanics);
}

class MechanicOperationSuccess extends MechanicState {
  final String message;

  MechanicOperationSuccess(this.message);
}

class MechanicError extends MechanicState {
  final String errorMessage;

  MechanicError(this.errorMessage);
}
