import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../../domain/entities/inventory.dart';
import '../../../infrastructure/services/firestore_inventory_service.dart';
import '../../bloc/inventory_bloc.dart';
import '../../../domain/entities/workshop.dart';
import '../../../domain/entities/spare_part.dart';
import '../../../infrastructure/services/firestore_spare_part_service.dart';
import '../../../infrastructure/services/firestore_workshop_service.dart';
import '../../bloc/spare_part_bloc.dart';
import '../../bloc/workshop_bloc.dart';
import '../../models/list_selector_item.dart';
import '../../widgets/selector_item.dart';
import 'inventory_list.dart';

class NewInventory extends StatefulWidget {
  const NewInventory({super.key});

  @override
  State<NewInventory> createState() => _NewInventoryState();
}

class _NewInventoryState extends State<NewInventory> {
  TextEditingController quantity = TextEditingController();
  TextEditingController reason = TextEditingController();
  TextEditingController entryDate = TextEditingController();

  var dateOfEntry = DateTime.now();
  late SparePart sparePart = SparePart(id: "", name: "Sin asignar", price: 0);
  late Workshop workShop = Workshop(id: "", name: "Sin asignar");
  List<String> typeInventory = ['Entrada', 'Salida'];
  List<Inventory> inventoryFindList = [];
  String typeInventorySelected = 'Entrada';
  String inventoryDocIdEdit = "";
  int inventoryQuantityEdit = 0;
  bool isEditable = false;

  @override
  Widget build(BuildContext context) {
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

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const InventoryList()),
            ),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Ingresar inventario',
            style: const TextStyle(color: Colors.white),
          )),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<SparePartBloc>(
              create: (context) => SparePartBloc(FirestoreSparePartService()),
            ),
            BlocProvider<SparePartBloc>(
                create: (context) => SparePartBloc(FirestoreSparePartService())
                  ..add(LoadSpareParts())),
            BlocProvider<WorkshopBloc>(
                create: (context) => WorkshopBloc(FirestoreWorkShopService())
                  ..add(LoadWorkShop())),
            BlocProvider<InventoryBloc>(
                create: (context) => InventoryBloc(
                    FirestoreInventoryService(), "Inventory", "", "")
                  ..add(LoadInventory())),
          ],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Text('Tipo de movimiento'),
                      const SizedBox(width: 10),
                      DropdownButton<String>(
                        value: typeInventorySelected,
                        items: typeInventory.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            typeInventorySelected = value!;
                          });
                        },
                      ),
                    ],
                  ),
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
                        labelText: 'Fecha del movimiento',
                        labelStyle: const TextStyle(color: Color(0XFF0879A6))),
                  ),
                  const SizedBox(height: 10),
                  BlocBuilder<InventoryBloc, InventoryState>(
                      builder: (context, state) {
                    if (state is InventoryLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is InventoryLoaded) {
                      final inventoryList = state.inventory;
                      inventoryFindList = inventoryList;
                      return Container();
                    } else if (state is InventoryError) {
                      return Center(child: Text(state.errorMessage));
                    } else {
                      return Container();
                    }
                  }),
                  BlocBuilder<SparePartBloc, SparePartState>(
                      builder: (context, state) {
                    if (state is SparePartLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SparePartLoaded) {
                      final spareParts = state.sparePart;
                      List<ListSelectorItem> listSelectorItem = [];
                      for (var element in spareParts) {
                        listSelectorItem.add(ListSelectorItem(
                            id: element.id, name: element.name));
                      }
                      return SelectorItem(
                          currentItemSelected: ListSelectorItem(
                            id: sparePart.id,
                            name: sparePart.name,
                          ),
                          items: listSelectorItem,
                          descriptor: 'Repuesto',
                          type: 1,
                          onSetItemFilter: (item) {
                            setState(() {
                              sparePart = SparePart(
                                  id: item.id, name: item.name, price: 0);
                            });
                          });
                    } else if (state is SparePartError) {
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
                    controller: quantity,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cantidad',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: reason,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        prefixIconColor: Color(0XFF0879A6),
                        labelText: 'Razon',
                        labelStyle: TextStyle(color: Color(0XFF0879A6))),
                  ),
                  const SizedBox(height: 10),
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
                                  builder: (context) => const InventoryList()),
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
                              if (inventoryFindList.any((e) =>
                                  e.sparePart.id == sparePart.id &&
                                  e.workShop.id == workShop.id)) {
                                var newQuantity = typeInventorySelected ==
                                        "Entrada"
                                    ? inventoryFindList
                                            .where((e) =>
                                                e.sparePart.id ==
                                                    sparePart.id &&
                                                e.workShop.id == workShop.id)
                                            .first
                                            .quantity +
                                        int.parse(quantity.text)
                                    : inventoryFindList
                                            .where((e) =>
                                                e.sparePart.id ==
                                                    sparePart.id &&
                                                e.workShop.id == workShop.id)
                                            .first
                                            .quantity -
                                        int.parse(quantity.text);
                                BlocProvider.of<InventoryBloc>(context).add(
                                    UpdateQuantityInventory(
                                        inventoryFindList
                                            .where((x) =>
                                                x.sparePart.id == sparePart.id)
                                            .first
                                            .docId!,
                                        newQuantity));
                                var inventoryMov = Inventory(
                                  id: firestoreAutoId(),
                                  date: dateOfEntry,
                                  sparePart: sparePart,
                                  workShop: workShop,
                                  quantity: int.parse(quantity.text),
                                  reason: reason.text,
                                  type: typeInventorySelected == "Entrada"
                                      ? "Entry"
                                      : "Output",
                                );
                                BlocProvider.of<InventoryBloc>(context)
                                    .add(AddInventory(inventoryMov));
                              } else {
                                var inventory = Inventory(
                                  id: firestoreAutoId(),
                                  date: dateOfEntry,
                                  sparePart: sparePart,
                                  workShop: workShop,
                                  quantity: int.parse(quantity.text),
                                  reason: reason.text,
                                  type: "Inventory",
                                );

                                var inventoryMov = Inventory(
                                  id: firestoreAutoId(),
                                  date: dateOfEntry,
                                  sparePart: sparePart,
                                  workShop: workShop,
                                  quantity: int.parse(quantity.text),
                                  reason: reason.text,
                                  type: "Entry",
                                );
                                BlocProvider.of<InventoryBloc>(context)
                                    .add(AddInventory(inventory));
                                BlocProvider.of<InventoryBloc>(context)
                                    .add(AddInventory(inventoryMov));
                              }
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const InventoryList()),
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
