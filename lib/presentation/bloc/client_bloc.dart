import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/client.dart';
import '../../infrastructure/services/firestore_clients_service.dart';
part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final FirestoreClientsService _firestoreService;

  ClientBloc(this._firestoreService) : super(ClientInitial()) {
    on<LoadClients>((event, emit) async {
      try {
        emit(ClientLoading());
        final clients = await _firestoreService.getClients().first;
        emit(ClientLoaded(clients));
      } catch (e) {
        emit(ClientError('Failed to load client.'));
      }
    });

    on<AddClient>((event, emit) async {
      try {
        emit(ClientLoading());
        await _firestoreService.addClient(event.client);
        emit(ClientOperationSuccess('Todo added successfully.'));
      } catch (e) {
        emit(ClientError('Failed to add todo.'));
      }
    });

    on<DeleteClient>((event, emit) async {
      try {
        emit(ClientLoading());
        await _firestoreService.deleteClient(event.id);
        emit(ClientOperationSuccess('Todo deleted successfully.'));
      } catch (e) {
        emit(ClientError('Failed to delete todo.'));
      }
    });
  }
}
