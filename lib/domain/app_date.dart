class AppDate {
  final int year;
  final int month;
  final int day;

  final int hour;
  final int minute;
  final int second;

  const AppDate._({
    required this.year,
    required this.month,
    required this.day,
    required this.hour,
    required this.minute,
    required this.second,
  });

  factory AppDate.fromDateTime(DateTime dateTime) {
    return AppDate._(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
      hour: dateTime.hour,
      minute: dateTime.minute,
      second: dateTime.second,
    );
  }

  factory AppDate.fromString(String dateTime) {
    final _dateTime = DateTime.parse(dateTime);
    return AppDate.fromDateTime(_dateTime);
  }

  factory AppDate.create({
    int? year,
    int? month,
    int? day,
    int? hour,
    int? minute,
    int? second,
  }) {
    final _now = DateTime.now();
    return AppDate._(
      year: year ?? _now.year,
      month: month ?? _now.month,
      day: day ?? _now.day,
      hour: hour ?? _now.hour,
      minute: minute ?? _now.minute,
      second: second ?? _now.second,
    );
  }

  factory AppDate.now() => AppDate.fromDateTime(DateTime.now());

  DateTime toDateTime() => DateTime(year, month, day, hour, minute, second);

  operator +(Duration duration) =>
      AppDate.fromDateTime(toDateTime().add(duration));

  operator -(Duration duration) =>
      AppDate.fromDateTime(toDateTime().add(duration));

  String get fmtDate =>
      '$year-${month.toString().padLeft(2, "0")}-${day.toString().padLeft(2, "0")}';

  String get fmtTime =>
      '${hour.toString().padLeft(2, "0")}:${minute.toString().padLeft(2, "0")}:${second.toString().padLeft(2, "0")}';
  String get fmtDateTime => '$fmtDate $fmtTime';

  String get fmtHumanDateTime =>
      '${day.toString().padLeft(2, "0")}/${month.toString().padLeft(2, "0")}/$year $fmtTime';

  @override
  String toString() => '$runtimeType($fmtDateTime)';
}
