part of 'spare_part_bloc.dart';

@immutable
abstract class SparePartState {}

class SparePartInitial extends SparePartState {}

class SparePartLoading extends SparePartState {}

class SparePartLoaded extends SparePartState {
  final List<SparePart> sparePart;

  SparePartLoaded(this.sparePart);
}

class SparePartOperationSuccess extends SparePartState {
  final String message;

  SparePartOperationSuccess(this.message);
}

class SparePartError extends SparePartState {
  final String errorMessage;

  SparePartError(this.errorMessage);
}
