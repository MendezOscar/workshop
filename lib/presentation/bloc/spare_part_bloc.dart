import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../infrastructure/services/firestore_spare_part_service.dart';
import '../../domain/entities/spare_part.dart';
part 'spare_part_event.dart';
part 'spare_part_state.dart';

class SparePartBloc extends Bloc<SparePartEvent, SparePartState> {
  final FirestoreSparePartService _firestoreService;

  SparePartBloc(this._firestoreService) : super(SparePartInitial()) {
    on<LoadSpareParts>((event, emit) async {
      try {
        emit(SparePartLoading());
        final clients = await _firestoreService.getSparePart().first;
        emit(SparePartLoaded(clients));
      } catch (e) {
        emit(SparePartError('Failed to load client.'));
      }
    });

    on<AddSparePart>((event, emit) async {
      try {
        emit(SparePartLoading());
        await _firestoreService.addSparePart(event.sparePart);
        emit(SparePartOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(SparePartError('Failed to add todo.'));
      }
    });

    on<DeleteSparePart>((event, emit) async {
      try {
        emit(SparePartLoading());
        await _firestoreService.deleteSparePart(event.id);
        emit(SparePartOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(SparePartError('Failed to delete todo.'));
      }
    });
  }
}
