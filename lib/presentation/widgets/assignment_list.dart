import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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
                FirestoreRepairSheetHeaderService(), widget.status)
              ..add(LoadRepairSheetHeader())),
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
                onChanged: (x) {},
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
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 0,
                                  color: Colors.blue.shade100.withOpacity(0.8),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 5,
                                        bottom: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Text(
                                              e.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            )),
                                            IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            AssignmentView(
                                                              repairSheetHeaderDocId:
                                                                  e.id,
                                                              isProcessed:
                                                                  e.status == 0
                                                                      ? false
                                                                      : true,
                                                              repairSheetHeader:
                                                                  e,
                                                            )),
                                                  );
                                                },
                                                icon: const Icon(
                                                  Icons.chevron_right_rounded,
                                                  size: 30,
                                                ))
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text('Estado: ',
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w300)),
                                            Expanded(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          16.0),
                                                  color: Colors.white,
                                                ),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Center(
                                                    child: Text(
                                                      getStatus(e.status),
                                                      style: const TextStyle(
                                                          fontSize: 16,
                                                          fontWeight:
                                                              FontWeight.w500),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text(
                                              'Problema: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              e.failure,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Cliente: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              e.client.name,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Posible solucion: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              e.solution,
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Taller: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              e.workShop?.name ?? 'Sin asignar',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            const Text(
                                              'Mecanico Asignado: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Text(
                                              e.mechanic?.name ?? 'Sin asignar',
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                        const Divider(
                                          height: 5,
                                        ),
                                        const SizedBox(height: 10),
                                        Row(
                                          children: [
                                            const Text(
                                              'Fecha de ingreso: ',
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w300),
                                            ),
                                            Expanded(
                                              child: Text(
                                                DateFormat('MMMM d')
                                                    .format(e.entryDate),
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ),
                                            e.status != 3
                                                ? Builder(builder: (context) {
                                                    return IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    RepairSheetHeaderBloc>(
                                                                context)
                                                            .add(
                                                                UpdateStatusRepairSheetHeader(
                                                                    e.docId!,
                                                                    3));
                                                        setState(() {
                                                          counter++;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.cancel,
                                                      ),
                                                      color: Colors.red,
                                                    );
                                                  })
                                                : Builder(builder: (context) {
                                                    return IconButton(
                                                      onPressed: () {
                                                        BlocProvider.of<
                                                                    RepairSheetHeaderBloc>(
                                                                context)
                                                            .add(
                                                                UpdateStatusRepairSheetHeader(
                                                                    e.docId!,
                                                                    0));
                                                        setState(() {
                                                          counter++;
                                                        });
                                                      },
                                                      icon: const Icon(
                                                        Icons.recycling,
                                                      ),
                                                      color: Colors.green,
                                                    );
                                                  }),
                                            Builder(builder: (context) {
                                              return IconButton(
                                                onPressed: () {
                                                  BlocProvider.of<
                                                              RepairSheetHeaderBloc>(
                                                          context)
                                                      .add(
                                                          DeleteRepairSheetHeader(
                                                              e.docId!));
                                                  setState(() {
                                                    counter++;
                                                  });
                                                },
                                                icon: const Icon(
                                                  Icons.delete,
                                                ),
                                                color: Colors.red,
                                              );
                                            })
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
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
    } else if (status == 1) {
      return "FINALIZADA";
    } else {
      return "CANCELADA";
    }
  }
}
