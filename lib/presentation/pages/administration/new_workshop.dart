import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/workshop.dart';
import '../../../infrastructure/services/firestore_workshop_service.dart';
import '../../bloc/workshop_bloc.dart';
import 'client_list.dart';
import 'workshop_list.dart';

class NewWorkshop extends StatefulWidget {
  const NewWorkshop({super.key});

  @override
  State<NewWorkshop> createState() => _NewWorkshopState();
}

class _NewWorkshopState extends State<NewWorkshop> {
  TextEditingController name = TextEditingController();
  TextEditingController direction = TextEditingController();
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
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const WorkshopList()),
            ),
          ),
          backgroundColor: const Color(0XFF0879A6),
          title: const Text(
            'Ingresar nueva tienda',
            style: TextStyle(color: Colors.white),
          )),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<WorkshopBloc>(
              create: (context) => WorkshopBloc(FirestoreWorkShopService()),
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
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    maxLines: 4,
                    controller: direction,
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
                              var workShop = Workshop(
                                  id: firestoreAutoId(),
                                  name: name.text,
                                  direction: direction.text,
                                  phone: phone.text,
                                  email: email.text);
                              BlocProvider.of<WorkshopBloc>(context)
                                  .add(AddWorkshop(workShop));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WorkshopList()),
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
