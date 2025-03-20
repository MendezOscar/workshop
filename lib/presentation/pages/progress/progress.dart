import 'package:flutter/material.dart';

import '../../widgets/pie_chart.dart';

class Progress extends StatelessWidget {
  const Progress({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          const Text(
            'Resumen de avance general',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 1,
                    color: const Color.fromARGB(255, 177, 203, 224),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.monetization_on,
                                color: Colors.blue,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Ventas',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              'L. 20,000',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 1,
                    color: const Color.fromARGB(255, 166, 229, 161),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.settings,
                                color: Colors.green,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Reparaciones',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '30',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 1,
                    color: const Color.fromARGB(255, 233, 200, 228),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.motorcycle,
                                color: Colors.pink,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Repuestos',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '67',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 1,
                    color: const Color.fromARGB(255, 238, 214, 172),
                    child: const Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(16.0),
                          child: CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                Icons.group,
                                color: Colors.orange,
                              )),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Clientes',
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              '25',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.blue),
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          const Text(
            'Resumen de avance por tiendas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
                height: size.height * 0.35,
                width: size.height * 0.5,
                child: BarChartSample2()),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.yellow,
                    ),
                    SizedBox(width: 5),
                    Text('Nuevas')
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Text('En proceso')
                  ],
                ),
                SizedBox(width: 10),
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.green,
                    ),
                    SizedBox(width: 5),
                    Text('Finalizadas')
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
