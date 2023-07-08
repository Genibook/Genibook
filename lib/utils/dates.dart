bool isTodaySummer() {
  DateTime now = DateTime.now();
  DateTime date = DateTime(now.year, now.month, now.day);
  DateTime summerStart = DateTime(now.year, 7, 1);
  return date.isAfter(summerStart);
}
