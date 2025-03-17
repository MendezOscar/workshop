import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/mechanic.dart';
import '../../infrastructure/services/firestore_mechanics_service.dart';
part 'mechanic_event.dart';
part 'mechanic_state.dart';

class MechanicBloc extends Bloc<MechanicEvent, MechanicState> {
  final FirestoreMechanicsService _firestoreService;

  MechanicBloc(this._firestoreService) : super(MechanicInitial()) {
    on<LoadMechanics>((event, emit) async {
      try {
        emit(MechanicLoading());
        final mechanics = await _firestoreService.getMechanics().first;
        emit(MechanicLoaded(mechanics));
      } catch (e) {
        emit(MechanicError('Failed to load client.'));
      }
    });

    on<AddMechanic>((event, emit) async {
      try {
        emit(MechanicLoading());
        await _firestoreService.addMechanic(event.mechanic);
        emit(MechanicOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(MechanicError('Failed to add todo.'));
      }
    });

    on<DeleteMechanic>((event, emit) async {
      try {
        emit(MechanicLoading());
        await _firestoreService.deleteMechanic(event.id);
        emit(MechanicOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(MechanicError('Failed to delete todo.'));
      }
    });
  }
}
