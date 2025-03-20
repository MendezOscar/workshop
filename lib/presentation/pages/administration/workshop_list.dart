import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rvmsmart/presentation/pages/administration/new_workshop.dart';
import '../../../domain/entities/workshop.dart';
import '../../../infrastructure/services/firestore_workshop_service.dart';
import '../../bloc/workshop_bloc.dart';
import '../../widgets/empty_state.dart';
import '../../widgets/information_card.dart';

class WorkshopList extends StatefulWidget {
  const WorkshopList({super.key});

  @override
  State<WorkshopList> createState() => _WorkshopListState();
}

class _WorkshopListState extends State<WorkshopList> {
  List<Workshop> searchedItems = [];
  int counter = 0;
  int keyCode = 0;

  @override
  void initState() {
    super.initState();
    counter = 0;
    keyCode = DateTime.now().millisecond.hashCode;
  }

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
      key: Key(counter.toString() + keyCode.toString()),
      providers: [
        BlocProvider<WorkshopBloc>(
            create: (context) =>
                WorkshopBloc(FirestoreWorkShopService())..add(LoadWorkShop())),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Lista de talleres',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFF0879A6),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NewWorkshop()),
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
                                'No existen datos creados o ocurrio algun error en la carga de datos')
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    filter(value, workshops);
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
                                      email: searchedItems[index].email,
                                      phone: searchedItems[index].phone,
                                      descriptor: "Taller",
                                      onDelete: () {
                                        {
                                          BlocProvider.of<WorkshopBloc>(context)
                                              .add(DeleteWorkshop(
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
