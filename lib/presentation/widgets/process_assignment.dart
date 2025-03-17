import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/repair_sheet_header.dart';
import '../../infrastructure/services/firestore_repair_sheet_header_service.dart';
import '../bloc/repair_sheet_header_bloc.dart';
import '../pages/main/home.dart';

class ProcessAssignment extends StatelessWidget {
  final void Function(bool) onSetProcessAssignment;
  final RepairSheetHeader repairSheetHeader;
  const ProcessAssignment(
      {super.key,
      required this.onSetProcessAssignment,
      required this.repairSheetHeader});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RepairSheetHeaderBloc>(
          create: (context) =>
              RepairSheetHeaderBloc(FirestoreRepairSheetHeaderService(), 0),
        ),
      ],
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 10),
            const CircleAvatar(
              radius: 30,
              backgroundColor: Color(0XFF0879A6),
              child: Icon(
                Icons.hourglass_empty,
                size: 35,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            const Text('Aun no se ha procesado la ficha de reparacion',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: OutlinedButton(
                      onPressed: () {
                        onSetProcessAssignment(true);
                      },
                      child: const Text('Procesar'),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Builder(builder: (context) {
                      return OutlinedButton(
                        onPressed: () {
                          BlocProvider.of<RepairSheetHeaderBloc>(context).add(
                              UpdateStatusRepairSheetHeader(
                                  repairSheetHeader.docId!, 3));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: "Bienvenido",
                                    )),
                          );
                        },
                        child: const Text(
                          'Cancelar',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: Builder(builder: (context) {
                      return OutlinedButton(
                        onPressed: () {
                          BlocProvider.of<RepairSheetHeaderBloc>(context).add(
                              DeleteRepairSheetHeader(
                                  repairSheetHeader.docId!));
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyHomePage(
                                      title: "Bienvenido",
                                    )),
                          );
                        },
                        child: const Text(
                          'Eliminar',
                          style: TextStyle(color: Colors.red),
                        ),
                      );
                    }),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
