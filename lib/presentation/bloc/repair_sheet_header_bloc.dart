import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/repair_sheet_header.dart';
import '../../infrastructure/services/firestore_repair_sheet_header_service.dart';
part 'repair_sheet_header_event.dart';
part 'repair_sheet_header_state.dart';

class RepairSheetHeaderBloc
    extends Bloc<RepairSheetHeaderEvent, RepairSheetHeaderState> {
  final FirestoreRepairSheetHeaderService _firestoreService;

  RepairSheetHeaderBloc(this._firestoreService, int status)
      : super(RepairSheetHeaderInitial()) {
    on<LoadRepairSheetHeader>((event, emit) async {
      try {
        emit(RepairSheetHeaderStateLoading());
        final todos =
            await _firestoreService.getRepairSheetHeaderByStatus(status).first;
        emit(RepairSheetHeaderStateLoaded(todos));
      } catch (e) {
        emit(RepairSheetHeaderStateError('Failed to load client.'));
      }
    });

    on<AddRepairSheetHeader>((event, emit) async {
      try {
        emit(RepairSheetHeaderStateLoading());
        await _firestoreService
            .addRepairSheetHeaderService(event.repairSheetHeader);
        emit(
            RepairSheetHeaderStateOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(RepairSheetHeaderStateError('Failed to add todo.'));
      }
    });

    on<UpdateRepairSheetHeader>((event, emit) async {
      try {
        emit(RepairSheetHeaderStateLoading());
        await _firestoreService.updateStatusRepairSheetHeaderService(
            event.repairSheetHeader.id, event.repairSheetHeader.status);
        emit(RepairSheetHeaderStateOperationSuccess(
            'Todo updated successfully.'));
      } catch (e) {
        emit(RepairSheetHeaderStateError('Failed to update todo.'));
      }
    });

    on<UpdateStatusRepairSheetHeader>((event, emit) async {
      try {
        emit(RepairSheetHeaderStateLoading());
        await _firestoreService.updateStatusRepairSheetHeaderService(
            event.repairSheetHeaderId, event.status);
        emit(RepairSheetHeaderStateOperationSuccess(
            'Todo updated successfully.'));
      } catch (e) {
        emit(RepairSheetHeaderStateError('Failed to update todo.'));
      }
    });

    on<DeleteRepairSheetHeader>((event, emit) async {
      try {
        emit(RepairSheetHeaderStateLoading());
        await _firestoreService.deleteRepairSheetHeader(event.id);
        emit(RepairSheetHeaderStateOperationSuccess(
            'Todo deleted successfully.'));
      } catch (e) {
        emit(RepairSheetHeaderStateError('Failed to delete todo.'));
      }
    });
  }
}
