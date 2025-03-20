import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../widgets/information_card.dart';
import 'new_mechanic.dart';
import '../../../domain/entities/mechanic.dart';
import '../../../infrastructure/services/firestore_mechanics_service.dart';
import '../../bloc/mechanic_bloc.dart';
import '../../widgets/empty_state.dart';

class MechanicList extends StatefulWidget {
  const MechanicList({super.key});

  @override
  State<MechanicList> createState() => _MechanicListState();
}

class _MechanicListState extends State<MechanicList> {
  List<Mechanic> searchedItems = [];
  int counter = 0;
  int keyCode = 0;

  @override
  void initState() {
    super.initState();
    counter = 0;
    keyCode = DateTime.now().millisecond.hashCode;
  }

  void filter(String searchText, List<Mechanic> items) {
    List<Mechanic> results = [];
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
        BlocProvider<MechanicBloc>(
            create: (context) => MechanicBloc(FirestoreMechanicsService())
              ..add(LoadMechanics())),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Lista de mecanicos',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFF0879A6),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NewMechanic()),
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
                BlocBuilder<MechanicBloc, MechanicState>(
                    builder: (context, state) {
                  if (state is MechanicLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is MechanicLoaded) {
                    final mechanics = state.mechanics;
                    searchedItems =
                        searchedItems.isEmpty ? state.mechanics : searchedItems;
                    return mechanics.isEmpty
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
                                    filter(value, mechanics);
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
                                      phone: searchedItems[index].phone,
                                      descriptor: "Mecanico",
                                      onDelete: () {
                                        {
                                          BlocProvider.of<MechanicBloc>(context)
                                              .add(DeleteMechanic(
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
                  } else if (state is MechanicError) {
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
