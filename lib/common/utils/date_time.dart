import 'package:intl/intl.dart';

extension DateTimeExtention on DateTime {
  DateTime toInit() {
    return DateTime(year, month, day);
  }

  String toAmericanFormatString({bool isShort = false}) {
    final formattedDate = DateFormat(isShort ? 'j' : 'jm').format(this).split(' ');
    return '${formattedDate.first}${formattedDate.last.toLowerCase()}';
  }

  String toServerFormatString() {
    return DateFormat('yyyy-MM-ddTHH:mm:ss').format(this);
  }

  bool isSameDate(DateTime compare) {
    return year == compare.year && month == compare.month && day == compare.day && hour == compare.hour;
  }
}
