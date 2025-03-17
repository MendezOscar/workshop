part of 'mechanic_bloc.dart';

@immutable
abstract class MechanicEvent {}

class LoadMechanics extends MechanicEvent {}

class AddMechanic extends MechanicEvent {
  final Mechanic mechanic;

  AddMechanic(this.mechanic);
}

class DeleteMechanic extends MechanicEvent {
  final String id;

  DeleteMechanic(this.id);
}
