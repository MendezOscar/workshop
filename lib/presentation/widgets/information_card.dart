import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InformationCard extends StatelessWidget {
  const InformationCard(
      {super.key,
      this.color,
      required this.name,
      this.email,
      this.phone,
      this.descriptor,
      this.price,
      this.brand,
      this.stock,
      this.workShop,
      this.reason,
      this.date,
      this.status,
      this.problem,
      this.solution,
      this.mechanic,
      this.client,
      this.onView,
      this.onDelete,
      this.onCancelOrRecycle,
      this.onEdit});

  final Color? color;
  final String name;
  final String? email;
  final String? phone;
  final String? descriptor;
  final String? price;
  final String? brand;
  final String? stock;
  final String? workShop;
  final String? reason;
  final DateTime? date;
  final String? status;
  final String? problem;
  final String? solution;
  final String? mechanic;
  final String? client;

  final void Function()? onDelete;
  final void Function()? onEdit;
  final void Function()? onView;
  final void Function()? onCancelOrRecycle;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      elevation: 1,
      color: color ?? Colors.white,
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 5),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                    child: Text(
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w300),
                        name)),
                if (descriptor != null && descriptor!.isNotEmpty)
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(color: Colors.green, spreadRadius: 1),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Text(
                        descriptor ?? "",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w300),
                      ),
                    ),
                  )
              ],
            ),
            const SizedBox(height: 15),
            if (email != null && email!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.email,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Email:'),
                  const SizedBox(width: 5),
                  Text(email ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (phone != null && phone!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.phone,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Telefono:'),
                  const SizedBox(width: 5),
                  Text(phone ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (brand != null && brand!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Marca:'),
                  const SizedBox(width: 5),
                  Text(brand ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (price != null && price!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.price_check,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Precio:'),
                  const SizedBox(width: 5),
                  Text('L. $price',
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (date != null)
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month,
                    color: Colors.orange,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Fecha:'),
                  const SizedBox(width: 5),
                  Text(DateFormat('MMMM d').format(date ?? DateTime.now()),
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (reason != null && reason!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.yellow,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Razon:'),
                  const SizedBox(width: 5),
                  Text(reason ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (problem != null && problem!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.red,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Problema:'),
                  const SizedBox(width: 5),
                  Text(problem ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (client != null && client!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.person,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Cliente:'),
                  const SizedBox(width: 5),
                  Text(client ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (solution != null && solution!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.info,
                    color: Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Solucion:'),
                  const SizedBox(width: 5),
                  Text(solution ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (mechanic != null && mechanic!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.settings,
                    color: Colors.deepPurpleAccent,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Mecanico:'),
                  const SizedBox(width: 5),
                  Text(mechanic ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (workShop != null && workShop!.isNotEmpty)
              Row(
                children: [
                  const Icon(
                    Icons.store,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Taller:'),
                  const SizedBox(width: 5),
                  Text(workShop ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            if (stock != null && stock!.isNotEmpty)
              Row(
                children: [
                  Icon(
                    Icons.inventory,
                    color: int.parse(stock!) < 5 ? Colors.red : Colors.green,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  const Text('Stock:'),
                  const SizedBox(width: 5),
                  Text(stock ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 16)),
                ],
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (onView != null)
                  IconButton(
                      onPressed: onView,
                      icon: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 154, 238, 203),
                        radius: 15,
                        child: Icon(
                          color: Colors.white,
                          Icons.remove_red_eye,
                          size: 15,
                        ),
                      )),
                if (onCancelOrRecycle != null && status != null)
                  IconButton(
                      onPressed: onCancelOrRecycle,
                      icon: CircleAvatar(
                        backgroundColor:
                            const Color.fromARGB(255, 238, 159, 154),
                        radius: 15,
                        child: Icon(
                          color: Colors.white,
                          status! != '3' ? Icons.cancel : Icons.replay,
                          size: 15,
                        ),
                      )),
                if (onEdit != null)
                  IconButton(
                      onPressed: () {},
                      icon: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 149, 201, 233),
                        radius: 15,
                        child: Icon(
                          color: Colors.white,
                          Icons.edit,
                          size: 15,
                        ),
                      )),
                if (onDelete != null)
                  IconButton(
                      onPressed: onDelete,
                      icon: const CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 238, 159, 154),
                        radius: 15,
                        child: Icon(
                          color: Colors.white,
                          Icons.delete,
                          size: 15,
                        ),
                      ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
