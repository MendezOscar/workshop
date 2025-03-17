import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rvmsmart/domain/entities/client.dart';
import 'package:rvmsmart/presentation/pages/administration/new_cliente.dart';
import '../../widgets/empty_state.dart';

import '../../../infrastructure/services/firestore_clients_service.dart';
import '../../bloc/client_bloc.dart';

class ClientList extends StatefulWidget {
  const ClientList({super.key});

  @override
  State<ClientList> createState() => _ClientListState();
}

class _ClientListState extends State<ClientList> {
  List<Client> searchedItems = [];

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
      providers: [
        BlocProvider<ClientBloc>(
            create: (context) =>
                ClientBloc(FirestoreClientsService())..add(LoadClients())),
      ],
      child: Scaffold(
        appBar: AppBar(
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
            padding: const EdgeInsets.all(16.0),
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
                                'No existen cleintes creados o ocurrio algun error en la carga de datos')
                        : Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextFormField(
                                  onChanged: (value) {
                                    filter(value, clients);
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
                                            Text(searchedItems[index].phone ??
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
