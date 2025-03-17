part of 'client_bloc.dart';

@immutable
abstract class ClientEvent {}

class LoadClients extends ClientEvent {}

class AddClient extends ClientEvent {
  final Client client;

  AddClient(this.client);
}

class DeleteClient extends ClientEvent {
  final String id;

  DeleteClient(this.id);
}
