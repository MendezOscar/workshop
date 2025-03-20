import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rvmsmart/presentation/widgets/information_card.dart';
import '../bloc/repair_sheet_header_bloc.dart';
import '../models/day_picker_model.dart';
import '../pages/assignment/assignment_view.dart';
import 'day_picker.dart';
import 'empty_state.dart';

import '../../infrastructure/services/firestore_repair_sheet_header_service.dart';

class AssignmentList extends StatefulWidget {
  final int status;
  const AssignmentList({super.key, required this.status});

  @override
  State<AssignmentList> createState() => _AssignmentListState();
}

class _AssignmentListState extends State<AssignmentList> {
  int counter = 0;
  DateTime date = DateTime.now();

  @override
  void initState() {
    super.initState();
    counter = 0;
  }

  getDates() {
    final items = List<DayPickerModel>.generate(
        100,
        (i) => DayPickerModel(
            titleName: getDayName(DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).add(Duration(days: -i))),
            date: DateTime.utc(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
            ).add(Duration(days: -i))));
    return items;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      key: Key(widget.status.toString() + counter.toString()),
      providers: [
        BlocProvider<RepairSheetHeaderBloc>(
            create: (context) => RepairSheetHeaderBloc(
                FirestoreRepairSheetHeaderService(), widget.status, date)
              ..add(LoadRepairSheetHeaderByStatusAndDate(widget.status, date))),
      ],
      child: BlocBuilder<RepairSheetHeaderBloc, RepairSheetHeaderState>(
          builder: (context, state) {
        if (state is RepairSheetHeaderStateLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RepairSheetHeaderStateLoaded) {
          final repairSheetHeader = state.repairSheetHeader;

          return Column(
            children: [
              DayPicker(
                selectedDate: date,
                onChanged: (x) {
                  date = x.date;
                  BlocProvider.of<RepairSheetHeaderBloc>(context).add(
                      LoadRepairSheetHeaderByStatusAndDate(
                          widget.status, date));
                },
                days: getDates(),
              ),
              repairSheetHeader.isEmpty
                  ? const EmptyState(
                      pathImage: "",
                      title: "Sin datos para mostrar",
                      message:
                          "Es posible que no tengas ninguna ficha de reparacion para esta fecha.")
                  : Column(
                      children: repairSheetHeader
                          .asMap()
                          .map((i, e) => MapEntry(
                              i,
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: InformationCard(
                                  color:
                                      const Color.fromARGB(255, 186, 219, 245),
                                  name: e.name,
                                  descriptor: getStatus(e.status),
                                  problem: e.failure,
                                  solution: e.solution,
                                  client: e.client.name,
                                  workShop: e.workShop!.name,
                                  mechanic: e.mechanic!.name,
                                  date: e.entryDate,
                                  status: e.status.toString(),
                                  onCancelOrRecycle: e.status != 3
                                      ? () {
                                          BlocProvider.of<
                                                      RepairSheetHeaderBloc>(
                                                  context)
                                              .add(
                                                  UpdateStatusRepairSheetHeader(
                                                      e.docId!, 3));
                                          setState(() {
                                            counter++;
                                          });
                                        }
                                      : () {
                                          BlocProvider.of<
                                                      RepairSheetHeaderBloc>(
                                                  context)
                                              .add(
                                                  UpdateStatusRepairSheetHeader(
                                                      e.docId!, 0));
                                          setState(() {
                                            counter++;
                                          });
                                        },
                                  onDelete: () {
                                    BlocProvider.of<RepairSheetHeaderBloc>(
                                            context)
                                        .add(DeleteRepairSheetHeader(e.docId!));
                                    setState(() {
                                      counter++;
                                    });
                                  },
                                  onView: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AssignmentView(
                                                repairSheetHeaderDocId: e.id,
                                                isProcessed: e.status == 0
                                                    ? false
                                                    : true,
                                                repairSheetHeader: e,
                                              )),
                                    );
                                  },
                                ),
                              )))
                          .values
                          .toList(),
                    ),
            ],
          );
        } else if (state is RepairSheetHeaderStateError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const EmptyState(
              pathImage: "",
              title: "Sin datos para mostrar",
              message:
                  "Es posible que no tengas ninguna ficha de reparacion para esta fecha.");
        }
      }),
    );
  }

  String getDayName(DateTime date) {
    var currentLocale = Intl.getCurrentLocale();
    if (DateUtils.dateOnly(date) == DateUtils.dateOnly(DateTime.now())) {
      return currentLocale.contains('es') ? 'Hoy' : 'Today';
    } else if (DateUtils.dateOnly(date) ==
        DateUtils.dateOnly(DateTime.now().subtract(Duration(days: 1)))) {
      return currentLocale.contains('es') ? 'Ayer' : 'Yesterday';
    } else {
      return DateFormat.EEEE(currentLocale).format(date);
    }
  }

  String getStatus(int status) {
    if (status == 0) {
      return "NUEVA";
    } else if (status == 1) {
      return "EN PROCESO";
    } else if (status == 2) {
      return "FINALIZADA";
    } else {
      return "CANCELADA";
    }
  }
}
