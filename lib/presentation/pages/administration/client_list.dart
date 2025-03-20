import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/client.dart';
import '../../widgets/information_card.dart';
import 'new_client.dart';
import '../../widgets/empty_state.dart';

import '../../../infrastructure/services/firestore_clients_service.dart';
import '../../bloc/client_bloc.dart';

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  int counter = 0;
  int keyCode = 0;
  List<Client> searchedItems = [];

  @override
  void initState() {
    super.initState();
    counter = 0;
    keyCode = DateTime.now().millisecond.hashCode;
  }

  void filter(String searchText, List<Client> items) {
    List<Client> results = [];
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
        BlocProvider<ClientBloc>(
            create: (context) =>
                ClientBloc(FirestoreClientsService())..add(LoadClients())),
      ],
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Lista de clientes',
            style: TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0XFF0879A6),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const NewClient()),
            );
          },
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                BlocBuilder<ClientBloc, ClientState>(builder: (context, state) {
                  if (state is ClientLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is ClientLoaded) {
                    final clients = state.clients;
                    searchedItems =
                        searchedItems.isEmpty ? state.clients : searchedItems;

                    return clients.isEmpty
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
                                    filter(value, clients);
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
                                      descriptor: "Cliente",
                                      onDelete: () {
                                        {
                                          BlocProvider.of<ClientBloc>(context)
                                              .add(DeleteClient(
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
                  } else if (state is ClientError) {
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
