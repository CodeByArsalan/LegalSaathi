import 'package:intl/intl.dart';

extension DateTimeX on DateTime {
  /// Wire format expected by the ASP.NET Core API.
  String get toApiDate => DateFormat('yyyy-MM-dd').format(this);

  DateTime get dateOnly => DateTime(year, month, day);

  bool isSameDay(DateTime other) =>
      year == other.year && month == other.month && day == other.day;

  bool get isToday => isSameDay(DateTime.now());
}
