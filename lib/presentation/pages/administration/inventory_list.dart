import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../infrastructure/services/firestore_inventory_service.dart';
import '../../bloc/inventory_bloc.dart';
import '../../../domain/entities/inventory.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/information_card.dart';
import 'inventory_movement_list.dart';
import 'new_inventory.dart';

class InventoryList extends StatefulWidget {
  const InventoryList({super.key});

  @override
  State<InventoryList> createState() => _InventoryState();
}

class _InventoryState extends State<InventoryList> {
  int counter = 0;
  int keyCode = 0;
  List<Inventory> searchedItems = [];

  @override
  void initState() {
    super.initState();
    counter = 0;
    keyCode = DateTime.now().millisecond.hashCode;
  }

  void filter(String searchText, List<Inventory> items) {
    List<Inventory> results = [];
    if (searchText.isEmpty) {
      results = items;
    } else {
      results = items
          .where((element) => element.sparePart.name
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    }

    setState(() {
      searchedItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<InventoryBloc>(
            create: (context) =>
                InventoryBloc(FirestoreInventoryService(), "Inventory", "", "")
                  ..add(LoadInventory())),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Movimientos de inventario',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFF0879A6),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NewInventory()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                BlocBuilder<InventoryBloc, InventoryState>(
                    builder: (context, state) {
                  if (state is InventoryLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is InventoryLoaded) {
                    final inventory = state.inventory;
                    searchedItems =
                        searchedItems.isEmpty ? state.inventory : searchedItems;

                    return inventory.isEmpty
                        ? const EmptyState(
                            pathImage: '',
                            title: 'Sin infromacion para mostrar',
                            message:
                                'No existen datos creados o ocurrio algun error en la carga de datos')
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    filter(value, inventory);
                                  },
                                  decoration: InputDecoration(
                                    suffixIcon: const Icon(Icons.search),
                                    labelText: "Buscar por nombre",
                                    fillColor: Colors.white,
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.blue,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: searchedItems.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InformationCard(
                                      name: searchedItems[index].sparePart.name,
                                      date: searchedItems[index].date,
                                      reason: searchedItems[index].reason,
                                      workShop:
                                          searchedItems[index].workShop.name,
                                      stock: searchedItems[index]
                                          .quantity
                                          .toString(),
                                      descriptor: "Inventario",
                                      onView: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InventoryMovementList(
                                                      sparePartName:
                                                          searchedItems[index]
                                                              .sparePart
                                                              .name,
                                                      sparePartId:
                                                          searchedItems[index]
                                                              .sparePart
                                                              .id,
                                                      workShopId:
                                                          searchedItems[index]
                                                              .workShop
                                                              .id)),
                                        );
                                      },
                                    );
                                  }),
                            ],
                          );
                  } else if (state is InventoryError) {
                    return Center(child: Text(state.errorMessage));
                  } else {
                    return Container();
                  }
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
