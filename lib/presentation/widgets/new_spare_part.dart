import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rvmsmart/infrastructure/services/firestore_spare_part_service.dart';
import 'package:rvmsmart/presentation/bloc/spare_part_bloc.dart';

import '../../domain/entities/spare_part.dart';

class NewSparePart extends StatefulWidget {
  const NewSparePart({super.key});

  @override
  State<NewSparePart> createState() => _NewSparePartState();
}

class _NewSparePartState extends State<NewSparePart> {
  List<SparePart> searchedItems = [];

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
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SparePartBloc>(
            create: (context) => SparePartBloc(FirestoreSparePartService())
              ..add(LoadSpareParts()))
      ],
      child:
          BlocBuilder<SparePartBloc, SparePartState>(builder: (context, state) {
        if (state is SparePartLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is SparePartLoaded) {
          final sparePartList = state.sparePart;
          searchedItems =
              searchedItems.isEmpty ? state.sparePart : searchedItems;

          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              children: [
                const SizedBox(height: 10),
                const Text("Lista de repuestos disponibles",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    onChanged: (value) {
                      filter(value, sparePartList);
                    },
                    decoration: const InputDecoration(
                        labelText: "Buscar por nombre",
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                ),
                const SizedBox(height: 10),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.all(8),
                    itemCount: searchedItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                          leading: Text((index + 1).toString(),
                              style: const TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.bold)),
                          title: Text(searchedItems[index].name),
                          trailing: IconButton(
                              onPressed: () {
                                Navigator.pop(context, searchedItems[index]);
                              },
                              icon: const Icon(Icons.check)));
                    }),
              ],
            ),
          );
        } else if (state is SparePartError) {
          return Center(child: Text(state.errorMessage));
        } else {
          return const Center(
            child: Text("Sin datos para mostrar"),
          );
        }
      }),
    );
  }
}
