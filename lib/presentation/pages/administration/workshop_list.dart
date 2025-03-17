import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/workshop.dart';
import '../../../infrastructure/services/firestore_workshop_service.dart';
import '../../bloc/workshop_bloc.dart';
import '../../widgets/empty_state.dart';

class WorkshopList extends StatefulWidget {
  const WorkshopList({super.key});

  @override
  State<WorkshopList> createState() => _WorkshopListState();
}

class _WorkshopListState extends State<WorkshopList> {
  List<Workshop> searchedItems = [];

  void filter(String searchText, List<Workshop> items) {
    List<Workshop> results = [];
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
        BlocProvider<WorkshopBloc>(
            create: (context) =>
                WorkshopBloc(FirestoreWorkShopService())..add(LoadWorkShop())),
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Lista de talleres',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFF0879A6),
          onPressed: () {
            // Navigator.pushReplacement(
            //   context,
            //   MaterialPageRoute(
            //       builder: (context) => const NewAssignment()),
            // );
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
                BlocBuilder<WorkshopBloc, WorkShopState>(
                    builder: (context, state) {
                  if (state is WorkShopLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is WorkShopLoaded) {
                    final workshops = state.workShop;
                    searchedItems =
                        searchedItems.isEmpty ? state.workShop : searchedItems;
                    return workshops.isEmpty
                        ? const EmptyState(
                            pathImage: '',
                            title: 'Sin infromacion para mostrar',
                            message:
                                'No existen cleintes creados o ocurrio algun error en la carga de datos')
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    filter(value, workshops);
                                  },
                                  decoration: const InputDecoration(
                                      labelText: "Buscar por nombre",
                                      labelStyle:
                                          TextStyle(color: Colors.black)),
                                ),
                              ),
                              ListView.builder(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  padding: const EdgeInsets.all(8),
                                  itemCount: searchedItems.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return ListTile(
                                        leading: Text((index + 1).toString(),
                                            style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold)),
                                        title: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(searchedItems[index].name),
                                            Text(searchedItems[index]
                                                    .direction ??
                                                ""),
                                          ],
                                        ),
                                        trailing: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.delete,
                                              color: Colors.red,
                                            )));
                                  }),
                            ],
                          );
                  } else if (state is WorkShopError) {
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
