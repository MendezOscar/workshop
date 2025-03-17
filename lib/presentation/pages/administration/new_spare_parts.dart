import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rvmsmart/domain/entities/spare_part.dart';
import 'package:rvmsmart/infrastructure/services/firestore_spare_part_service.dart';
import 'package:rvmsmart/presentation/bloc/spare_part_bloc.dart';
import 'package:rvmsmart/presentation/pages/administration/spare_part_list.dart';
import '../../../domain/entities/client.dart';
import 'client_list.dart';
import '../../bloc/client_bloc.dart';

class NewSparePart extends StatefulWidget {
  const NewSparePart({super.key});

  @override
  State<NewSparePart> createState() => _NewSparePartState();
}

class _NewSparePartState extends State<NewSparePart> {
  TextEditingController name = TextEditingController();
  TextEditingController brand = TextEditingController();
  TextEditingController description = TextEditingController();
  TextEditingController price = TextEditingController();
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
            'Ingresar nueo repuesto',
            style: const TextStyle(color: Colors.white),
          )),
      body: MultiBlocProvider(
          providers: [
            BlocProvider<SparePartBloc>(
              create: (context) => SparePartBloc(FirestoreSparePartService()),
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
                    controller: brand,
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Marca',
                        labelStyle: TextStyle(fontWeight: FontWeight.w400)),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: description,
                    maxLines: 4,
                    decoration: const InputDecoration(
                        prefixIconColor: Color(0XFF0879A6),
                        labelText: 'Descripcion',
                        labelStyle: TextStyle(color: Color(0XFF0879A6))),
                  ),
                  const SizedBox(height: 10),
                  TextField(
                    controller: price,
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly
                    ],
                    decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Precio',
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
                                  builder: (context) => const SparePartList()),
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
                              var sparePart = SparePart(
                                id: firestoreAutoId(),
                                name: name.text,
                                description: description.text,
                                brand: brand.text,
                                price: int.parse(price.text),
                              );
                              BlocProvider.of<SparePartBloc>(context)
                                  .add(AddSparePart(sparePart));
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const SparePartList()),
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
