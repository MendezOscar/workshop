import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/repair_sheet_details.dart';
import '../../infrastructure/services/firestore_repair_sheet_details_service.dart';

part 'repair_sheet_details_event.dart';
part 'repair_sheet_details_state.dart';

class RepairSheetDetailsBloc
    extends Bloc<RepairSheetDetailsEvent, RepairSheetDetailsState> {
  final FirestoreRepairSheetDetailsService _firestoreService;

  RepairSheetDetailsBloc(this._firestoreService, String headerId)
      : super(RepairSheetDetailsInitial()) {
    on<LoadRepairSheetDetails>((event, emit) async {
      try {
        emit(RepairSheetDetailsStateLoading());
        final todos = await _firestoreService.getRepairSheetDetails().first;
        emit(RepairSheetDetailsStateLoaded(todos.first));
      } catch (e) {
        emit(RepairSheetDetailsStateError('Failed to load client.'));
      }
    });

    on<LoadRepairSheetDetailsByHeaderId>((event, emit) async {
      try {
        emit(RepairSheetDetailsStateLoading());
        final todos = await _firestoreService
            .getRepairSheetDetailsByHeaderId(headerId)
            .first;
        emit(RepairSheetDetailsStateLoaded(todos));
      } catch (e) {
        emit(RepairSheetDetailsStateError('Failed to load client.'));
      }
    });

    on<AddRepairSheetDetails>((event, emit) async {
      try {
        emit(RepairSheetDetailsStateLoading());
        await _firestoreService
            .addRepairSheetDetailsService(event.repairSheetDetails);
        emit(RepairSheetDetailsStateOperationSuccess(
            'Todo added successfully.'));
      } catch (e) {
        emit(RepairSheetDetailsStateError('Failed to add todo.'));
      }
    });
  }
}
