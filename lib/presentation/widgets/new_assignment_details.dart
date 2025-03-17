import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../domain/entities/repair_sheet_details.dart';
import '../../domain/entities/spare_part.dart';
import '../../infrastructure/services/firestore_repair_sheet_details_service.dart';
import '../bloc/repair_sheet_details_bloc.dart';
import '../pages/main/home.dart';
import 'new_spare_part.dart';

import '../../domain/entities/repair_sheet_header.dart';
import '../../infrastructure/services/firestore_repair_sheet_header_service.dart';
import '../bloc/repair_sheet_header_bloc.dart';

class NewAssignmentDetails extends StatefulWidget {
  final void Function(bool) onSetProcessAssignment;
  final RepairSheetHeader repairSheetHeader;
  final String repairSheetHeaderId;
  const NewAssignmentDetails(
      {super.key,
      required this.onSetProcessAssignment,
      required this.repairSheetHeaderId,
      required this.repairSheetHeader});

  @override
  State<NewAssignmentDetails> createState() => _NewAssignmentDetailsState();
}

class _NewAssignmentDetailsState extends State<NewAssignmentDetails> {
  TextEditingController serviceDescription = TextEditingController();
  TextEditingController servicePrice = TextEditingController();
  TextEditingController sparePartsPrice = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController departureDate = TextEditingController();
  late List<SparePart> sparePartList = [];
  late List<int> sparePartPriceLIst = [];
  var dateOfEntry = DateTime.now();
  int totalRepairCost = 0;
  late SparePart sparePart;
  int number = 0;

  @override
  void dispose() {
    sparePartsPrice.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    number = 0;
    sparePartsPrice.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    void callNewSparePartModalBottomSheet() {
      showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext context) {
          return const SizedBox(
            child: Center(child: NewSparePart()),
          );
        },
      ).then((value) => {
            if (value == null)
              {}
            else
              {
                setState(() {
                  number++;
                }),
                sparePartList.add(value),
                sparePartPriceLIst.add(value.price),
                sparePartsPrice.text =
                    sparePartPriceLIst.reduce((a, e) => a + e).toString()
              },
          });
    }

    String firestoreAutoId() {
      Random random = Random();
      const chars =
          "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      var autoId = "";

      for (var i = 0; i < 20; i++) {
        autoId += chars[random.nextInt(chars.length)];
      }
      return autoId;
    }

    return MultiBlocProvider(
      providers: [
        BlocProvider<RepairSheetDetailsBloc>(
          create: (context) => RepairSheetDetailsBloc(
              FirestoreRepairSheetDetailsService(), widget.repairSheetHeaderId),
        ),
        BlocProvider<RepairSheetHeaderBloc>(
          create: (context) =>
              RepairSheetHeaderBloc(FirestoreRepairSheetHeaderService(), 0),
        )
      ],
      child: Column(
        children: [
          TextField(
            controller: serviceDescription,
            maxLines: 4,
            decoration: const InputDecoration(
                prefixIconColor: Color(0XFF0879A6),
                labelText: 'Descripcion del servicio',
                labelStyle: TextStyle(color: Color(0XFF0879A6))),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: servicePrice,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Precio del servicio realizado',
                labelStyle: TextStyle(fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 20),
          ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              padding: const EdgeInsets.all(8),
              itemCount: sparePartList.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    leading: Text((index + 1).toString(),
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold)),
                    title: Text(sparePartList[index].name),
                    trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            sparePartList.removeAt(index);
                          });
                        },
                        icon: const Icon(Icons.delete, color: Colors.red)));
              }),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const Text(
                'Agregar respuesto utilizado',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              CircleAvatar(
                  backgroundColor: const Color(0XFF0879A6),
                  child: IconButton(
                      onPressed: () {
                        callNewSparePartModalBottomSheet();
                      },
                      icon: const Icon(
                        Icons.add,
                        color: Colors.white,
                      ))),
            ],
          ),
          const SizedBox(height: 20),
          TextField(
            controller: sparePartsPrice,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Total de los repuestos utilizados',
                labelStyle: TextStyle(fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: departureDate,
            onTap: () async {
              DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1950),
                  lastDate: DateTime(2101));
              if (pickedDate != null) {
                String formattedDate = DateFormat('MMMM d').format(pickedDate);
                dateOfEntry = pickedDate;
                setState(() {
                  departureDate.text = formattedDate;
                });
              } else {}
            },
            decoration: InputDecoration(
                prefixIconColor: const Color(0XFF0879A6),
                prefixIcon: const Icon(Icons.calendar_month),
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Color(0XFF0879A6)),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                labelText: 'Fecha de salida',
                labelStyle: const TextStyle(color: Color(0XFF0879A6))),
          ),
          const SizedBox(height: 20),
          const Divider(height: 5),
          const SizedBox(height: 20),
          TextField(
            controller: discount,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly
            ],
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Descuento',
                labelStyle: TextStyle(fontWeight: FontWeight.w400)),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              OutlinedButton(
                onPressed: () {
                  setState(() {
                    totalRepairCost = (int.parse(servicePrice.text) +
                            int.parse(sparePartsPrice.text)) -
                        int.parse(discount.text);
                  });
                },
                child: const Text('Calcular precio total de repacion'),
              ),
              const SizedBox(width: 10),
              Text(
                'L. ${totalRepairCost.toString()}',
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    color: Color(0XFF0879A6)),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Builder(builder: (context) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    child: OutlinedButton(
                      onPressed: () {
                        var repairSheetDetails = RepairSheetDetails(
                            repairSheetHeaderId: widget.repairSheetHeaderId,
                            departureDate: dateOfEntry,
                            serviceDescription: serviceDescription.text,
                            servicePrice: int.parse(servicePrice.text),
                            spareParts: sparePartList,
                            sparePartsPrice: int.parse(sparePartsPrice.text),
                            discount: int.parse(discount.text),
                            totalRepairCost: totalRepairCost,
                            id: firestoreAutoId());
                        BlocProvider.of<RepairSheetDetailsBloc>(context)
                            .add(AddRepairSheetDetails(repairSheetDetails));

                        BlocProvider.of<RepairSheetHeaderBloc>(context).add(
                            UpdateStatusRepairSheetHeader(
                                widget.repairSheetHeader.docId!, 1));

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MyHomePage(
                                    title: "Bienvenido",
                                  )),
                        );
                      },
                      child: const Text('Guardar'),
                    ),
                  ),
                );
              }),
            ],
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
