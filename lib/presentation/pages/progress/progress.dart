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
            'Resumen de avance por tiendas',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w300),
          ),
          const SizedBox(height: 10),
          Center(
            child: SizedBox(
                height: size.height * 0.5,
                width: size.height * 0.5,
                child: BarChartSample2()),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Text('Nuevas')
                  ],
                ),
                SizedBox(width: 20),
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
