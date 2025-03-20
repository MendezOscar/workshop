import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/client.dart';
import '../../../domain/entities/mechanic.dart';
import '../../../domain/entities/repair_sheet_header.dart';
import '../../../infrastructure/services/firestore_repair_sheet_header_service.dart';
import '../../bloc/client_bloc.dart';
import 'package:intl/intl.dart';
import '../../bloc/mechanic_bloc.dart';
import '../../bloc/repair_sheet_header_bloc.dart';
import '../../bloc/workshop_bloc.dart';
import '../main/home.dart';

import '../../../domain/entities/workshop.dart';
import '../../../infrastructure/services/firestore_clients_service.dart';
import '../../../infrastructure/services/firestore_mechanics_service.dart';
import '../../../infrastructure/services/firestore_workshop_service.dart';
import '../../models/list_selector_item.dart';
import '../../widgets/selector_item.dart';

class NewAssignment extends StatefulWidget {
  const NewAssignment({super.key});

  @override
  State<NewAssignment> createState() => _NewAssignmentState();
}

class _NewAssignmentState extends State<NewAssignment> {
  TextEditingController item = TextEditingController();
  TextEditingController failure = TextEditingController();
  TextEditingController solution = TextEditingController();
  TextEditingController entryDate = TextEditingController();
  TextEditingController serviceDescription = TextEditingController();
  TextEditingController servicePrice = TextEditingController();
  TextEditingController sparePartsPrice = TextEditingController();
  TextEditingController discount = TextEditingController();
  TextEditingController departureDate = TextEditingController();
  late Mechanic mechanic;
  late Client client;
  late Workshop workShop;

  @override
  void initState() {
    super.initState();
    mechanic = Mechanic(id: '123456794', name: 'Sin asignar');
    client = Client(id: '121354756', name: 'Sin asignar');
    workShop = Workshop(id: '123456794', name: 'Sin asignar');
  }

  @override
  Widget build(BuildContext context) {
    var dateOfEntry = DateTime.now();

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
        BlocProvider<ClientBloc>(
            create: (context) =>
                ClientBloc(FirestoreClientsService())..add(LoadClients())),
        BlocProvider<MechanicBloc>(
            create: (context) => MechanicBloc(FirestoreMechanicsService())
              ..add(LoadMechanics())),
        BlocProvider<RepairSheetHeaderBloc>(
          create: (context) => RepairSheetHeaderBloc(
              FirestoreRepairSheetHeaderService(), 0, DateTime.now()),
        ),
        BlocProvider<WorkshopBloc>(
            create: (context) =>
                WorkshopBloc(FirestoreWorkShopService())..add(LoadWorkShop())),
      ],
      child: Scaffold(
          appBar: AppBar(
              leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const MyHomePage(
                                  title: "Bienvenido",
                                  index: 1,
                                )),
                      )),
              backgroundColor: const Color(0XFF0879A6),
              title: const Text(
                'Nueva asignacion de trabajo',
                style: TextStyle(color: Colors.white),
              )),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: item,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Articulo',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: failure,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Problema',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: solution,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Posible solucion',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<ClientBloc, ClientState>(
                      builder: (context, state) {
                    if (state is ClientLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is ClientLoaded) {
                      final clients = state.clients;
                      List<ListSelectorItem> listSelectorItem = [];
                      clients.forEach((element) => listSelectorItem.add(
                          ListSelectorItem(
                              id: element.id,
                              name: element.name,
                              phone: element.phone)));
                      return SelectorItem(
                          currentItemSelected: ListSelectorItem(
                              id: client.id,
                              name: client.name,
                              phone: client.phone),
                          items: listSelectorItem,
                          descriptor: 'Cliente',
                          type: 1,
                          onSetItemFilter: (item) {
                            setState(() {
                              client = Client(
                                  id: item.id,
                                  name: item.name,
                                  phone: item.phone);
                            });
                          });
                    } else if (state is ClientError) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return Container();
                    }
                  }),
                  const SizedBox(height: 10),
                  BlocBuilder<MechanicBloc, MechanicState>(
                      builder: (context, state) {
                    if (state is MechanicLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is MechanicLoaded) {
                      final mechanics = state.mechanics;
                      List<ListSelectorItem> listSelectorItem = [];
                      mechanics.forEach((element) => listSelectorItem.add(
                          ListSelectorItem(
                              id: element.id,
                              name: element.name,
                              phone: element.phone)));
                      return SelectorItem(
                          currentItemSelected: ListSelectorItem(
                              id: mechanic.id,
                              name: mechanic.name,
                              phone: mechanic.phone),
                          items: listSelectorItem,
                          descriptor: 'Mecanico asignado',
                          type: 1,
                          onSetItemFilter: (item) {
                            setState(() {
                              mechanic = Mechanic(
                                  id: item.id,
                                  name: item.name,
                                  phone: item.phone);
                            });
                          });
                    } else if (state is MechanicError) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return Container();
                    }
                  }),
                  const SizedBox(height: 10),
                  BlocBuilder<WorkshopBloc, WorkShopState>(
                      builder: (context, state) {
                    if (state is WorkShopLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is WorkShopLoaded) {
                      final workShops = state.workShop;
                      List<ListSelectorItem> listSelectorItem = [];
                      workShops.forEach((element) => listSelectorItem.add(
                          ListSelectorItem(
                              id: element.id, name: element.name, phone: "")));
                      return SelectorItem(
                          currentItemSelected: ListSelectorItem(
                              id: workShop.id, name: workShop.name, phone: ""),
                          items: listSelectorItem,
                          descriptor: 'Taller ',
                          type: 1,
                          onSetItemFilter: (item) {
                            setState(() {
                              workShop = Workshop(
                                id: item.id,
                                name: item.name,
                              );
                            });
                          });
                    } else if (state is WorkShopError) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return Container();
                    }
                  }),
                  const SizedBox(height: 10),
                  TextField(
                    controller: entryDate,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(1950),
                          lastDate: DateTime(2101));
                      if (pickedDate != null) {
                        String formattedDate =
                            DateFormat('MMMM d').format(pickedDate);
                        dateOfEntry = pickedDate;

                        setState(() {
                          entryDate.text = formattedDate;
                        });
                      } else {}
                    },
                    decoration: InputDecoration(
                        prefixIconColor: const Color(0XFF0879A6),
                        prefixIcon: const Icon(Icons.calendar_month),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(color: Color(0XFF0879A6)),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        labelText: 'Fecha de ingreso',
                        labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                  ),
                  const SizedBox(height: 20),
                  const Divider(height: 5),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const MyHomePage(
                                        title: "Bienvenido",
                                        index: 1,
                                      )),
                            );
                          },
                          child: const Text('Cancelar',
                              style: TextStyle(color: Colors.red)),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Builder(builder: (context) {
                        return Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              var repairSheetHeader = RepairSheetHeader(
                                  id: firestoreAutoId(),
                                  name: item.text,
                                  failure: failure.text,
                                  solution: solution.text,
                                  client: client,
                                  mechanic: mechanic,
                                  workShop: workShop,
                                  entryDate: dateOfEntry,
                                  status: 0);
                              BlocProvider.of<RepairSheetHeaderBloc>(context)
                                  .add(AddRepairSheetHeader(repairSheetHeader));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MyHomePage(
                                          title: "Bienvenido",
                                          index: 1,
                                        )),
                              );
                            },
                            child: const Text('Crear'),
                          ),
                        );
                      })
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }
}
