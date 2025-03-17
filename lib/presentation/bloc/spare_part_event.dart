part of 'spare_part_bloc.dart';

@immutable
abstract class SparePartEvent {}

class LoadSpareParts extends SparePartEvent {}

class AddSparePart extends SparePartEvent {
  final SparePart sparePart;

  AddSparePart(this.sparePart);
}

class DeleteSparePart extends SparePartEvent {
  final String id;

  DeleteSparePart(this.id);
}
