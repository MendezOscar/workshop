import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../infrastructure/services/firestore_inventory_service.dart';

import '../../domain/entities/inventory.dart';
part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final FirestoreInventoryService _firestoreService;

  InventoryBloc(this._firestoreService, String type, String sparePartId,
      String workShopId)
      : super(InventoryInitial()) {
    on<LoadInventory>((event, emit) async {
      try {
        emit(InventoryLoading());
        final todos = await _firestoreService.getInventoryByType(type).first;
        emit(InventoryLoaded(todos));
      } catch (e) {
        emit(InventoryError('Failed to load client.'));
      }
    });

    on<LoadInventoryByTypeAndSparePart>((event, emit) async {
      try {
        emit(InventoryLoading());
        final todos = await _firestoreService
            .getInventoryByTypeAndSparePart(type, sparePartId, workShopId)
            .first;
        emit(InventoryLoaded(todos));
      } catch (e) {
        emit(InventoryError('Failed to load client.'));
      }
    });

    on<AddInventory>((event, emit) async {
      try {
        emit(InventoryLoading());
        await _firestoreService.addInventory(event.inventory);
        emit(InventoryOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(InventoryError('Failed to add todo.'));
      }
    });

    // on<UpdateInventory>((event, emit) async {
    //   try {
    //     emit(InventoryLoading());
    //     await _firestoreService.updateInventoryService(
    //         event.repairSheetHeader.id, event.repairSheetHeader.status);
    //     emit(InventoryOperationSuccess(
    //         'Todo updated successfully.'));
    //   } catch (e) {
    //     emit(InventoryError('Failed to update todo.'));
    //   }
    // });

    on<UpdateQuantityInventory>((event, emit) async {
      try {
        emit(InventoryLoading());
        await _firestoreService.updateInventoryService(
            event.inventoryId, event.quantity);
        emit(InventoryOperationSuccess('Todo updated successfully.'));
      } catch (e) {
        emit(InventoryError('Failed to update todo.'));
      }
    });

    on<DeleteInventory>((event, emit) async {
      try {
        emit(InventoryLoading());
        await _firestoreService.deleteInventory(event.id);
        emit(InventoryOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(InventoryError('Failed to delete todo.'));
      }
    });
  }
}
