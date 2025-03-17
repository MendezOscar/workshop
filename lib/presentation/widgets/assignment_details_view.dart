import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rvmsmart/domain/entities/repair_sheet_details.dart';

import '../../infrastructure/services/firestore_repair_sheet_header_service.dart';
import '../bloc/repair_sheet_header_bloc.dart';

class AssignmentDetailsView extends StatelessWidget {
  final String repairSheetHeaderId;
  final RepairSheetDetails repairSheetDetails;
  const AssignmentDetailsView(
      {super.key,
      required this.repairSheetDetails,
      required this.repairSheetHeaderId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RepairSheetHeaderBloc>(
          create: (context) =>
              RepairSheetHeaderBloc(FirestoreRepairSheetHeaderService(), 0),
        )
      ],
      child: Column(
        children: [
          const Text(
            'Descripcion del Servicio realizado',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0XFF0879A6)),
          ),
          const SizedBox(height: 10),
          Text(
            repairSheetDetails.serviceDescription ?? '',
            maxLines: 7,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Total por servicio',
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: Color(0XFF0879A6)),
              )),
              Text(
                repairSheetDetails.servicePrice.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 5),
          const SizedBox(height: 10),
          const Text(
            'Repuestos utilizados',
            style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w800,
                color: Color(0XFF0879A6)),
          ),
          const SizedBox(height: 10),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: repairSheetDetails.spareParts!.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text((index + 1).toString(),
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold)),
                  title: Text(repairSheetDetails.spareParts![index].name),
                  trailing: const Icon(Icons.delete, color: Colors.red),
                );
              }),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Total por los respuestos',
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: Color(0XFF0879A6)),
              )),
              Text(
                repairSheetDetails.sparePartsPrice.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
          const Divider(height: 5),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(
                  child: Text(
                'Total por reparacion',
                style: TextStyle(
                    fontWeight: FontWeight.w800, color: Color(0XFF0879A6)),
              )),
              Text(
                repairSheetDetails.totalRepairCost.toString(),
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Colors.green),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Divider(height: 5),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                  child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(width: 2.0, color: Colors.blue),
                      ),
                      onPressed: () {},
                      child: const Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: Text(
                          'Enviar informacion al cliente',
                          textAlign: TextAlign.center,
                        ),
                      ))),
              const SizedBox(width: 10),
              Expanded(child: Builder(builder: (context) {
                return OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(width: 2.0, color: Colors.red),
                    ),
                    onPressed: () {
                      BlocProvider.of<RepairSheetHeaderBloc>(context).add(
                          UpdateStatusRepairSheetHeader(
                              repairSheetHeaderId, 1));
                    },
                    child: const Text('Finalizar reparacion'));
              }))
            ],
          )
        ],
      ),
    );
  }
}
