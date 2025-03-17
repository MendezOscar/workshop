import 'package:flutter/material.dart';

import '../models/list_selector_item.dart';
import 'list_selector_modal.dart';

class SelectorItem extends StatefulWidget {
  final void Function(ListSelectorItem) onSetItemFilter;
  final ListSelectorItem currentItemSelected;
  final List<ListSelectorItem> items;
  final String descriptor;
  final int type;

  const SelectorItem(
      {super.key,
      required this.onSetItemFilter,
      required this.currentItemSelected,
      required this.items,
      required this.descriptor,
      required this.type});

  @override
  State<SelectorItem> createState() => _SelectorItemState();
}

class _SelectorItemState extends State<SelectorItem> {
  late ListSelectorItem item = widget.currentItemSelected;

  @override
  Widget build(BuildContext context) {
    void callListSelectorModalBottomSheet() async {
      var value = await showModalBottomSheet(
          backgroundColor: Colors.transparent,
          context: context,
          builder: (context) {
            return ListSelectorModal(
              title: widget.type == 1
                  ? 'Seleccione un cliente'
                  : 'Seleccione un mecanico',
              items: widget.items,
            );
          });
      if (value != null && value != widget.currentItemSelected) {
        widget.onSetItemFilter(value);
        setState(() {
          item = value;
        });
      }
    }

    return Row(
      children: [
        Text('${widget.descriptor} : ',
            style: const TextStyle(fontWeight: FontWeight.w400)),
        Expanded(
            child: Card(
          color: const Color(0XFF0879A6).withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Row(
              children: [
                Expanded(
                  child: Text(item.name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 18,
                          fontStyle: FontStyle.italic)),
                ),
                IconButton(
                    onPressed: () {
                      callListSelectorModalBottomSheet();
                    },
                    icon: const Icon(Icons.keyboard_arrow_down))
              ],
            ),
          ),
        )),
      ],
    );
  }
}
