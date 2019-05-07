DateTime todayUtc(){
  DateTime now = new DateTime.now();
  return startOfDay(new DateTime.utc(now.year, now.month, now.day));
}

DateTime startOfDay(DateTime date){
  if (date == null) return null;
  if (date.isUtc) {
    return new DateTime.utc(date.year, date.month, date.day, 0, 0, 0);
  } else {
    return new DateTime(date.year, date.month, date.day, 0, 0, 0);
  }
}

DateTime endOfDay(DateTime date){
  if (date == null) return null;
  if (date.isUtc) {
    return new DateTime.utc(date.year, date.month, date.day, 23, 59, 59);
  } else {
    return new DateTime(date.year, date.month, date.day, 23, 59, 59);
  }
}

DateTime firstDayOfMonth(DateTime today) {
  return DateTime(today.year, today.month);
}

DateTime lastDayOfMonth(DateTime today) {
  return (today.month < 12) ?
    DateTime(today.year, today.month + 1, 0, 23, 59, 59) :
    DateTime(today.year + 1, 1, 0, 23, 59, 59);
}


