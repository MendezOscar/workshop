import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/information_card.dart';
import 'new_spare_parts.dart';
import '../../../domain/entities/spare_part.dart';
import '../../../infrastructure/services/firestore_spare_part_service.dart';
import '../../bloc/spare_part_bloc.dart';
import '../../widgets/empty_state.dart';

class SparePartList extends StatefulWidget {
  const SparePartList({super.key});

  @override
  State<SparePartList> createState() => _SparePartListState();
}

class _SparePartListState extends State<SparePartList> {
  List<SparePart> searchedItems = [];
  int counter = 0;
  int keyCode = 0;

  void filter(String searchText, List<SparePart> items) {
    List<SparePart> results = [];
    if (searchText.isEmpty) {
      results = items;
    } else {
      results = items
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    setState(() {
      searchedItems = results;
    });
  }

  @override
  void initState() {
    super.initState();
    counter = 0;
    keyCode = DateTime.now().millisecond.hashCode;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      key: Key(counter.toString() + keyCode.toString()),
      providers: [
        BlocProvider<SparePartBloc>(
            create: (context) => SparePartBloc(FirestoreSparePartService())
              ..add(LoadSpareParts())),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Lista de repuestos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFF0879A6),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NewSparePart()),
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
                BlocBuilder<SparePartBloc, SparePartState>(
                    builder: (context, state) {
                  if (state is SparePartLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is SparePartLoaded) {
                    final sparePart = state.sparePart;
                    searchedItems =
                        searchedItems.isEmpty ? state.sparePart : searchedItems;
                    return sparePart.isEmpty
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
                                    filter(value, sparePart);
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
                                      name: searchedItems[index].name,
                                      brand: searchedItems[index].brand,
                                      price:
                                          searchedItems[index].price.toString(),
                                      descriptor: "Repuesto",
                                      onDelete: () {
                                        {
                                          BlocProvider.of<SparePartBloc>(
                                                  context)
                                              .add(DeleteSparePart(
                                                  searchedItems[index].docId!));
                                          setState(() {
                                            searchedItems = [];
                                            counter++;
                                            keyCode = DateTime.now().hashCode;
                                          });
                                        }
                                      },
                                    );
                                  }),
                            ],
                          );
                  } else if (state is SparePartError) {
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
