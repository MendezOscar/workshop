part of 'workshop_bloc.dart';

@immutable
abstract class WorkShopState {}

class WorkShopInitial extends WorkShopState {}

class WorkShopLoading extends WorkShopState {}

class WorkShopLoaded extends WorkShopState {
  final List<Workshop> workShop;

  WorkShopLoaded(this.workShop);
}

class WorkShopOperationSuccess extends WorkShopState {
  final String message;

  WorkShopOperationSuccess(this.message);
}

class WorkShopError extends WorkShopState {
  final String errorMessage;

  WorkShopError(this.errorMessage);
}
