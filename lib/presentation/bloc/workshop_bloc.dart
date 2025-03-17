import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/workshop.dart';
import '../../infrastructure/services/firestore_workshop_service.dart';
part 'workshop_event.dart';
part 'workshop_state.dart';

class WorkshopBloc extends Bloc<WorkShopEvent, WorkShopState> {
  final FirestoreWorkShopService _firestoreService;

  WorkshopBloc(this._firestoreService) : super(WorkShopInitial()) {
    on<LoadWorkShop>((event, emit) async {
      try {
        emit(WorkShopLoading());
        final clients = await _firestoreService.getWorkShop().first;
        emit(WorkShopLoaded(clients));
      } catch (e) {
        emit(WorkShopError('Failed to load client.'));
      }
    });

    on<AddWorkshop>((event, emit) async {
      try {
        emit(WorkShopLoading());
        await _firestoreService.addWorkshop(event.workshop);
        emit(WorkShopOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(WorkShopError('Failed to add todo.'));
      }
    });

    on<DeleteWorkshop>((event, emit) async {
      try {
        emit(WorkShopLoading());
        await _firestoreService.deleteWorkshop(event.id);
        emit(WorkShopOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(WorkShopError('Failed to delete todo.'));
      }
    });
  }
}
