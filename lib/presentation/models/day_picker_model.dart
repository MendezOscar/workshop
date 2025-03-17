class DayPickerModel {
  const DayPickerModel({
    required this.date,
    this.titleName,
    this.name,
  });

  final DateTime date;
  final String? titleName;
  final String? name;
}
