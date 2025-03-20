part of 'repair_sheet_header_bloc.dart';

@immutable
abstract class RepairSheetHeaderEvent {}

class LoadRepairSheetHeader extends RepairSheetHeaderEvent {}

class LoadRepairSheetHeaderByStatusAndDate extends RepairSheetHeaderEvent {
  final int status;
  final DateTime date;

  LoadRepairSheetHeaderByStatusAndDate(this.status, this.date);
}

class AddRepairSheetHeader extends RepairSheetHeaderEvent {
  final RepairSheetHeader repairSheetHeader;

  AddRepairSheetHeader(this.repairSheetHeader);
}

class UpdateStatusRepairSheetHeader extends RepairSheetHeaderEvent {
  final String repairSheetHeaderId;
  final int status;

  UpdateStatusRepairSheetHeader(this.repairSheetHeaderId, this.status);
}

class UpdateRepairSheetHeader extends RepairSheetHeaderEvent {
  final RepairSheetHeader repairSheetHeader;

  UpdateRepairSheetHeader(this.repairSheetHeader);
}

class DeleteRepairSheetHeader extends RepairSheetHeaderEvent {
  final String id;

  DeleteRepairSheetHeader(this.id);
}
