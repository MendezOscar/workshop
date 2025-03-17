part of 'repair_sheet_header_bloc.dart';

@immutable
abstract class RepairSheetHeaderState {}

class RepairSheetHeaderInitial extends RepairSheetHeaderState {}

class RepairSheetHeaderStateLoading extends RepairSheetHeaderState {}

class RepairSheetHeaderStateLoaded extends RepairSheetHeaderState {
  final List<RepairSheetHeader> repairSheetHeader;

  RepairSheetHeaderStateLoaded(this.repairSheetHeader);
}

class RepairSheetHeaderStateOperationSuccess extends RepairSheetHeaderState {
  final String message;

  RepairSheetHeaderStateOperationSuccess(this.message);
}

class RepairSheetHeaderStateError extends RepairSheetHeaderState {
  final String errorMessage;

  RepairSheetHeaderStateError(this.errorMessage);
}
