part of 'inventory_bloc.dart';

@immutable
abstract class InventoryState {}

class InventoryInitial extends InventoryState {}

class InventoryLoading extends InventoryState {}

class InventoryLoaded extends InventoryState {
  final List<Inventory> inventory;

  InventoryLoaded(this.inventory);
}

class InventoryOperationSuccess extends InventoryState {
  final String message;

  InventoryOperationSuccess(this.message);
}

class InventoryError extends InventoryState {
  final String errorMessage;

  InventoryError(this.errorMessage);
}
