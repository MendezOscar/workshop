import 'package:flutter/material.dart';
import 'package:rvmsmart/presentation/pages/administration/inventory_list.dart';
import 'client_list.dart';
import 'mechanic_list.dart';
import 'spare_part_list.dart';
import 'workshop_list.dart';

class Administration extends StatefulWidget {
  const Administration({super.key});

  @override
  State<Administration> createState() => _AdministrationState();
}

class _AdministrationState extends State<Administration> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.group, color: Color(0XFF0879A6)),
              title: const Text('Clientes'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ClientList()),
                    );
                  },
                  icon: const Icon(Icons.chevron_right)),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.person, color: Color(0XFF0879A6)),
              title: const Text('Mecanicos'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MechanicList()),
                    );
                  },
                  icon: const Icon(Icons.chevron_right)),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.store, color: Color(0XFF0879A6)),
              title: const Text('Talleres'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WorkshopList()),
                    );
                  },
                  icon: const Icon(Icons.chevron_right)),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.motorcycle, color: Color(0XFF0879A6)),
              title: const Text('Repuestos'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SparePartList()),
                    );
                  },
                  icon: const Icon(Icons.chevron_right)),
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: const Icon(Icons.playlist_add_check,
                  color: Color(0XFF0879A6)),
              title: const Text('Inventario'),
              trailing: IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const InventoryList()),
                    );
                  },
                  icon: const Icon(Icons.chevron_right)),
            )
          ],
        ),
      ),
    );
  }
}
