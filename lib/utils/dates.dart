bool isTodaySummer() {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  DateTime summerStart = DateTime(now.year, 7, 1);
  DateTime summerEnd = DateTime(now.year, 8, 20);
  return date.isAfter(summerStart) && date.isBefore(summerEnd);
}
