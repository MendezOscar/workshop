import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:rvmsmart/domain/entities/repair_sheet_header.dart';
import 'package:rvmsmart/presentation/widgets/assignment_details_view.dart';
import 'package:rvmsmart/presentation/widgets/empty_state.dart';

import '../../../infrastructure/services/firestore_repair_sheet_details_service.dart';
import '../../bloc/repair_sheet_details_bloc.dart';
import '../../widgets/new_assignment_details.dart';
import '../../widgets/process_assignment.dart';

class AssignmentView extends StatefulWidget {
  final bool isProcessed;
  final RepairSheetHeader repairSheetHeader;
  final String repairSheetHeaderDocId;

  const AssignmentView(
      {super.key,
      required this.repairSheetHeader,
      required this.isProcessed,
      required this.repairSheetHeaderDocId});

  @override
  State<AssignmentView> createState() => _AssignmentViewState();
}

class _AssignmentViewState extends State<AssignmentView> {
  bool activeProcessed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: Text(
            widget.repairSheetHeader.name,
            style: const TextStyle(color: Colors.white),
          )),
      body: MultiBlocProvider(
        providers: [
          BlocProvider<RepairSheetDetailsBloc>(
              create: (context) => RepairSheetDetailsBloc(
                  FirestoreRepairSheetDetailsService(),
                  widget.repairSheetHeader.id)
                ..add(LoadRepairSheetDetailsByHeaderId()))
        ],
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(
                  'Ficha de reparacion de ${widget.repairSheetHeader.name}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: Color(0XFF0879A6)),
                ),
                const SizedBox(height: 20),
                const Divider(height: 5),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Problema: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      widget.repairSheetHeader.failure,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Cliente: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      widget.repairSheetHeader.client.name,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Posible solucion: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      widget.repairSheetHeader.solution,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Mecanico Asignado: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      widget.repairSheetHeader.mechanic?.name ?? "Sin asignar",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Taller: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      widget.repairSheetHeader.workShop?.name ?? "Sin asignar",
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 5),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text(
                      'Fecha de ingreso: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    ),
                    Text(
                      DateFormat('MMMM d')
                          .format(widget.repairSheetHeader.entryDate),
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                const Divider(height: 5),
                const SizedBox(height: 10),
                widget.isProcessed
                    ? BlocBuilder<RepairSheetDetailsBloc,
                        RepairSheetDetailsState>(builder: (context, state) {
                        if (state is RepairSheetDetailsStateLoading) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (state is RepairSheetDetailsStateLoaded) {
                          return state.repairSheetDetails == null
                              ? const EmptyState(
                                  pathImage: '',
                                  title: 'Sin datos para mostrar',
                                  message:
                                      'Es posible que tu ficha haya sido cancelada, finalizada o elimanda.')
                              : AssignmentDetailsView(
                                  repairSheetHeaderId:
                                      widget.repairSheetHeader.docId!,
                                  repairSheetDetails:
                                      state.repairSheetDetails!);
                        } else if (state is RepairSheetDetailsStateError) {
                          return const EmptyState(
                              pathImage: '',
                              title: 'Sin datos para mostrar',
                              message:
                                  'Es posible que tu ficha haya sido cancelada, finalizada o elimanda.');
                        } else {
                          return const Center(
                            child: Text("Sin datos para mostrar"),
                          );
                        }
                      })
                    : activeProcessed
                        ? NewAssignmentDetails(
                            onSetProcessAssignment: (value) {
                              setState(() {
                                activeProcessed = true;
                              });
                            },
                            repairSheetHeader: widget.repairSheetHeader,
                            repairSheetHeaderId: widget.repairSheetHeader.id)
                        : ProcessAssignment(
                            onSetProcessAssignment: (value) {
                              setState(() {
                                activeProcessed = true;
                              });
                            },
                            repairSheetHeader: widget.repairSheetHeader,
                          )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
