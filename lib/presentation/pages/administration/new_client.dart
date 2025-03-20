import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/client.dart';
import 'client_list.dart';
import '../../../infrastructure/services/firestore_clients_service.dart';
import '../../bloc/client_bloc.dart';

class NewClient extends StatefulWidget {
  const NewClient({super.key});

  @override
  State<NewClient> createState() => _NewClientState();
}

class _NewClientState extends State<NewClient> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController direction = TextEditingController();
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
              MaterialPageRoute(builder: (context) => const ClientList()),
            ),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Ingresar nuevo cliente',
            style: const TextStyle(color: Colors.white),
          )),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<ClientBloc>(
              create: (context) => ClientBloc(FirestoreClientsService()),
            ),
          ],
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextField(
                    controller: name,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Nombre',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: phone,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Telefono',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: email,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Correo',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: direction,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Direccion',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
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
                                  builder: (context) => const ClientList()),
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
                              var client = Client(
                                id: firestoreAutoId(),
                                name: name.text,
                                phone: phone.text,
                                email: email.text,
                                direction: direction.text,
                              );
                              BlocProvider.of<ClientBloc>(context)
                                  .add(AddClient(client));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ClientList()),
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
