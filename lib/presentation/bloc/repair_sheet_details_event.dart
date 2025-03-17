part of 'repair_sheet_details_bloc.dart';

@immutable
abstract class RepairSheetDetailsEvent {}

class LoadRepairSheetDetails extends RepairSheetDetailsEvent {}

class LoadRepairSheetDetailsByHeaderId extends RepairSheetDetailsEvent {}

class AddRepairSheetDetails extends RepairSheetDetailsEvent {
  final RepairSheetDetails repairSheetDetails;

  AddRepairSheetDetails(this.repairSheetDetails);
}
