part of 'workshop_bloc.dart';

@immutable
abstract class WorkShopEvent {}

class LoadWorkShop extends WorkShopEvent {}

class AddWorkshop extends WorkShopEvent {
  final Workshop workshop;

  AddWorkshop(this.workshop);
}

class DeleteWorkshop extends WorkShopEvent {
  final String id;

  DeleteWorkshop(this.id);
}
