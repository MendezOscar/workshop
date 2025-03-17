import 'package:flutter/material.dart';
import '../assignment/new_assignment.dart';

import '../../widgets/assignment_types.dart';
import '../administration/administration.dart';
import '../progress/progress.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = [
    const Progress(),
    const AssignmentTypes(),
    const Administration(),
  ];
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0XFF0879A6),
          title: Text(
            widget.title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        floatingActionButton: _selectedIndex == 1
            ? FloatingActionButton(
                backgroundColor: const Color(0XFF0879A6),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const NewAssignment()),
                  );
                },
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              )
            : Container(),
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(30),
                topLeft: Radius.circular(30),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              boxShadow: [
                BoxShadow(
                    color: Color(0XFF0879A6), spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
                bottomLeft: Radius.circular(30.0),
                bottomRight: Radius.circular(30.0),
              ),
              child: BottomNavigationBar(
                backgroundColor: const Color(0XFF0879A6),
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    backgroundColor: Color(0XFF0879A6),
                    activeIcon: Icon(Icons.equalizer),
                    icon: Icon(Icons.equalizer_outlined),
                    label: 'Avance',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Color(0XFF0879A6),
                    activeIcon: Icon(Icons.list),
                    icon: Icon(Icons.list_outlined),
                    label: 'Mis Asignaciones',
                  ),
                  BottomNavigationBarItem(
                    backgroundColor: Color(0XFF0879A6),
                    activeIcon: Icon(Icons.edit),
                    icon: Icon(Icons.edit_outlined),
                    label: 'Administracion',
                  ),
                ],
                currentIndex: _selectedIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                onTap: _onItemTapped,
              ),
            ),
          ),
        ));
  }
}
