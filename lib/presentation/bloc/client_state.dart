part of 'client_bloc.dart';

@immutable
abstract class ClientState {}

class ClientInitial extends ClientState {}

class ClientLoading extends ClientState {}

class ClientLoaded extends ClientState {
  final List<Client> clients;

  ClientLoaded(this.clients);
}

class ClientOperationSuccess extends ClientState {
  final String message;

  ClientOperationSuccess(this.message);
}

class ClientError extends ClientState {
  final String errorMessage;

  ClientError(this.errorMessage);
}
