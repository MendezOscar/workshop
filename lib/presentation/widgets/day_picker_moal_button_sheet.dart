import 'package:flutter/material.dart';
import 'calendar_selector.dart';

import '../models/day_picker_model.dart';

class DayPickerModalButtonSheet {
  final List<DateTime>? dates;
  final String title;
  final List<DayPickerModel> days;
  final void Function(DateTime index)? onSelected;
  final DateTime startDeadline;
  final DateTime endDeadline;

  const DayPickerModalButtonSheet(
      {required this.title,
      required this.days,
      this.dates,
      this.onSelected,
      required this.startDeadline,
      required this.endDeadline});

  Future<T?> show<T>(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) {
        return FractionallySizedBox(
          heightFactor: 0.65,
          child: Container(
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
                        title,
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
                  Expanded(
                      child: SingleChildScrollView(
                          child: CalendarSelector(
                    dates: dates,
                    startDeadline: startDeadline,
                    endDeadline: endDeadline,
                    onSelected: onSelected,
                  )))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
