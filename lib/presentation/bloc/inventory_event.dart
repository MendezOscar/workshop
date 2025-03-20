part of 'inventory_bloc.dart';

@immutable
abstract class InventoryEvent {}

class LoadInventory extends InventoryEvent {}

class LoadInventoryByTypeAndSparePart extends InventoryEvent {}

class AddInventory extends InventoryEvent {
  final Inventory inventory;

  AddInventory(this.inventory);
}

class UpdateQuantityInventory extends InventoryEvent {
  final String inventoryId;
  final int quantity;

  UpdateQuantityInventory(this.inventoryId, this.quantity);
}

class UpdateInventory extends InventoryEvent {
  final Inventory inventory;

  UpdateInventory(this.inventory);
}

class DeleteInventory extends InventoryEvent {
  final String id;

  DeleteInventory(this.id);
}
