import 'package:falta_quanto_tempo_pro_role/domain/app_date.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('create at today', () {
    final today = DateTime.now();
    final horaDoRole = AppDate.create(hour: 17, minute: 28, second: 0);

    expect(horaDoRole.day, today.day);
    expect(horaDoRole.month, today.month);
    expect(horaDoRole.year, today.year);
    expect(horaDoRole.hour, 17);
    expect(horaDoRole.minute, 28);
    expect(horaDoRole.second, 0);
  });

  test('format', () {
    final horaDoRole = AppDate.create(
      day: 27,
      month: 07,
      year: 2022,
      hour: 17,
      minute: 04,
      second: 29,
    );
    expect(horaDoRole.fmtTime, '17:04:29');
    expect(horaDoRole.fmtDate, '2022-07-27');
    expect(horaDoRole.fmtDateTime, '2022-07-27 17:04:29');
    expect(horaDoRole.fmtHumanDateTime, '27/07/2022 17:04:29');
    expect(horaDoRole.toString(), 'AppDate(2022-07-27 17:04:29)');
  });
}
