import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../enums/movement.dart';
import '../models/day_picker_model.dart';
import 'day_picker_moal_button_sheet.dart';

class DayPicker extends StatefulWidget {
  final List<DayPickerModel> days;
  final void Function(DayPickerModel) onChanged;

  const DayPicker({super.key, required this.days, required this.onChanged});

  @override
  State<DayPicker> createState() => _DayPickerState();
}

class _DayPickerState extends State<DayPicker> {
  bool disableButtonRight = false;
  bool disableButtonLeft = false;
  int arrayPositionItem = 0;
  DateTime? temporalDate;
  DayPickerModel itemDayPicker =
      DayPickerModel(date: DateTime.now(), titleName: 'Hoy');

  void goTo(int itemIndex, Movement movement) {
    setState(() {
      arrayPositionItem = itemIndex;

      disableButtonLeft = arrayPositionItem >= widget.days.length - 1;
      disableButtonRight = arrayPositionItem <= 0;
      itemDayPicker = widget.days.elementAt(arrayPositionItem);
      widget.onChanged(itemDayPicker);
    });
  }

  @override
  void initState() {
    super.initState();
    itemDayPicker = widget.days.first;
    goTo(0, Movement.none);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
        color: const Color(0XFF0879A6),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 23.0,
                    backgroundColor:
                        disableButtonLeft ? Colors.grey : Colors.white,
                    child: IconButton(
                      splashRadius: 5,
                      icon: Icon(Icons.chevron_left,
                          color:
                              disableButtonLeft ? Colors.white : Colors.grey),
                      onPressed: disableButtonLeft
                          ? null
                          : () => goTo(arrayPositionItem + 1, Movement.back),
                    ),
                  )
                ],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            foregroundColor: Colors.black,
                            elevation: 0),
                        onPressed: () {
                          DayPickerModalButtonSheet(
                              startDeadline: DateTime(DateTime.now().year,
                                  DateTime.now().month - 4, DateTime.now().day),
                              endDeadline: DateTime(DateTime.now().year,
                                  DateTime.now().month + 1, 0),
                              title: "Selecciona un dia para ver el detalle",
                              days: widget.days,
                              onSelected: (index) => {
                                    // temporalDate = index,
                                    // widget.days.any((element) =>
                                    //         element.date.contains(index))
                                    //     ? _goTo(
                                    //         widget.days.indexOf(widget.days
                                    //             .firstWhere((i) =>
                                    //                 DateUtils.isSameDay(
                                    //                     i.date.first, index))),
                                    //         temporalDate,
                                    //         Movement.none)
                                    //     : _goTo(-1, temporalDate, Movement.none)
                                  }).show(context);
                        },
                        child: Column(
                          children: [
                            Text(
                              itemDayPicker.titleName == null ||
                                      itemDayPicker.titleName!.isEmpty
                                  ? DateFormat.EEEE()
                                      .format(itemDayPicker.date.toLocal())
                                  : itemDayPicker.titleName!,
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16),
                            ),
                            Text(_itemSubtitleFormat(itemDayPicker),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  CircleAvatar(
                    radius: 23.0,
                    backgroundColor:
                        disableButtonRight ? Colors.grey : Colors.white,
                    child: IconButton(
                      splashRadius: 5,
                      icon: Icon(Icons.chevron_right,
                          color:
                              disableButtonRight ? Colors.white : Colors.grey),
                      onPressed: disableButtonRight
                          ? null
                          : () => goTo(arrayPositionItem - 1, Movement.back),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  String _itemSubtitleFormat(DayPickerModel item) {
    var text = item.name == null || item.name!.isEmpty
        ? DateFormat.yMMMd().format(item.date)
        : '${item.name!} - ${DateFormat.yMMMd().format(item.date)}';
    return text;
  }
}
