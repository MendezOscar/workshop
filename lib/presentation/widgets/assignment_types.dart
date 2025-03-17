import 'package:flutter/material.dart';

import 'assignment_list.dart';

const _news = 0;
const _progress = 1;
const _done = 2;
const _cancel = 3;

class AssignmentTypes extends StatefulWidget {
  const AssignmentTypes({super.key});

  @override
  State<AssignmentTypes> createState() => _AssignmentTypesState();
}

class _AssignmentTypesState extends State<AssignmentTypes>
    with TickerProviderStateMixin {
  late final TabController _tabController;
  List<Widget> tabs = [];
  int? index;
  int counterChanges = 0;

  void _changeIndex() {
    if (index != _tabController.index && mounted) {
      setState(() {
        index = _tabController.index;

        switch (index) {
          case _news:
            break;

          case _progress:
            break;

          case _done:
            break;

          case _cancel:
            break;

          default:
            break;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 4,
      initialIndex: index = 0,
      vsync: this,
    )..addListener(_changeIndex);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<Widget> prepareTabItems(BuildContext context) {
    return tabs = <Widget>[
      const AssignmentList(status: 0),
      const AssignmentList(status: 1),
      const AssignmentList(status: 2),
      const AssignmentList(status: 3),
    ];
  }

  @override
  Widget build(BuildContext context) {
    prepareTabItems(context);

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 10),
          TabBar(
            controller: _tabController,
            indicatorColor: const Color(0XFF0879A6),
            labelStyle:
                const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
            tabs: const <Widget>[
              Tab(
                icon: Icon(Icons.star, color: Color(0XFF0879A6)),
                text: 'Nuevas',
              ),
              Tab(
                icon: Icon(Icons.watch_later, color: Color(0XFF0879A6)),
                text: 'En Progreso',
              ),
              Tab(
                icon: Icon(Icons.done_all, color: Color(0XFF0879A6)),
                text: 'Finalizadas',
              ),
              Tab(
                icon: Icon(Icons.cancel, color: Color(0XFF0879A6)),
                text: 'Canceladas',
              )
            ],
          ),
          Builder(builder: (context) {
            return tabs[index!];
          })
        ],
      ),
    );
  }
}
