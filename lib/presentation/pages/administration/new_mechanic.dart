import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/mechanic.dart';
import '../../../infrastructure/services/firestore_mechanics_service.dart';
import '../../bloc/mechanic_bloc.dart';
import 'mechanic_list.dart';

class NewMechanic extends StatefulWidget {
  const NewMechanic({super.key});

  @override
  State<NewMechanic> createState() => _NewMechanicState();
}

class _NewMechanicState extends State<NewMechanic> {
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController email = TextEditingController();
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
            onPressed: () => Navigator.of(context).pop(),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Ingresar nuevo mecanico',
            style: const TextStyle(color: Colors.white),
          )),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<MechanicBloc>(
              create: (context) => MechanicBloc(FirestoreMechanicsService()),
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
                                  builder: (context) => const MechanicList()),
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
                              var mechanic = Mechanic(
                                id: firestoreAutoId(),
                                name: name.text,
                                phone: phone.text,
                              );
                              BlocProvider.of<MechanicBloc>(context)
                                  .add(AddMechanic(mechanic));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const MechanicList()),
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
