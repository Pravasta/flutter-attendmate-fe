const List<String> _dayNames = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Sunday'
];

const List<String> _monthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

extension DateTimeExt on DateTime {
  String toFormattedDayTime() {
    String dayName = _dayNames[weekday - 1];
    return '$dayName, ${toFormattedTime()}';
  }

  String toFormattedDate() {
    return '$day.$month.$year';
  }

  String toFormattedMonth() {
    return _monthNames[month - 1];
  }

  String toFormattedDayMonthYear() {
    String dayName = _dayNames[weekday - 1].substring(0, 3);
    return '$dayName, $day ${_monthNames[month - 1].substring(0, 3)} $year';
  }

  String toFormattedTime() {
    String hour = this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    return '$hour:$minute WIB';
  }

  // toformattedtime in AM/PM format. and only use for 12 hours format
  String toFormattedTimeAMPM() {
    String hour = this.hour > 12
        ? (this.hour - 12).toString().padLeft(2, '0')
        : this.hour.toString().padLeft(2, '0');
    String minute = this.minute.toString().padLeft(2, '0');
    String ampm = this.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $ampm';
  }
}
