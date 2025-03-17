import 'package:flutter/material.dart';

import '../models/list_selector_item.dart';

class ListSelectorModal extends StatefulWidget {
  final String title;
  final List<ListSelectorItem> items;

  const ListSelectorModal({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<ListSelectorModal> createState() => _ListSelectorModalState();
}

class _ListSelectorModalState extends State<ListSelectorModal> {
  List<ListSelectorItem> searchedItems = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      searchedItems = widget.items;
    });
  }

  void filter(String searchText) {
    List<ListSelectorItem> results = [];
    if (searchText.isEmpty) {
      results = widget.items;
    } else {
      results = widget.items
          .where((element) =>
              element.name.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    }

    setState(() {
      searchedItems = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: const TextStyle(
                    color: Color(0xFF15314D),
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                )
              ],
            ),
            TextFormField(
              onChanged: (value) {
                filter(value);
              },
              decoration: const InputDecoration(
                  labelText: "Buscar por nombre",
                  labelStyle: TextStyle(color: Colors.black)),
            ),
            Expanded(
                child: SingleChildScrollView(
              child: Column(
                children: searchedItems
                    .asMap()
                    .map((i, e) => MapEntry(
                        i,
                        ListTile(
                          contentPadding: EdgeInsets.all(4),
                          minLeadingWidth: 4,
                          dense: true,
                          leading: const Icon(Icons.person,
                              color: Color(0xFF15314D)),
                          title: Text(
                            e.name,
                            style: const TextStyle(
                              color: Color(0xFF15314D),
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          subtitle: Text(
                            e.id,
                            style: const TextStyle(
                              color: Color(0xFF929DB3),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          onTap: () {
                            Navigator.pop(context, e);
                          },
                        )))
                    .values
                    .toList(),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
