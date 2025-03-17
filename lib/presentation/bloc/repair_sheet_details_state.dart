part of 'repair_sheet_details_bloc.dart';

@immutable
abstract class RepairSheetDetailsState {}

class RepairSheetDetailsInitial extends RepairSheetDetailsState {}

class RepairSheetDetailsStateLoading extends RepairSheetDetailsState {}

class RepairSheetDetailsStateLoaded extends RepairSheetDetailsState {
  final RepairSheetDetails? repairSheetDetails;

  RepairSheetDetailsStateLoaded(this.repairSheetDetails);
}

class RepairSheetDetailsStateOperationSuccess extends RepairSheetDetailsState {
  final String message;

  RepairSheetDetailsStateOperationSuccess(this.message);
}

class RepairSheetDetailsStateError extends RepairSheetDetailsState {
  final String errorMessage;

  RepairSheetDetailsStateError(this.errorMessage);
}
