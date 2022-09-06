import 'dart:async';

import 'package:falta_quanto_tempo_pro_role/domain/app_date.dart';
import 'package:falta_quanto_tempo_pro_role/domain/app_role.dart';
import 'package:flutter/material.dart';

final role = AppRole(
  'Praiera em Magistério!!',
  AppDate.create(
    day: 07,
    month: 09,
    year: 2022,
    hour: 09,
    minute: 00,
    second: 00,
  ),
);

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color currentColor = Colors.blue;

  Duration remaining = const Duration();

  bool get isRunning => true;

  @override
  initState() {
    super.initState();
    _getRemainingTime().listen((event) {
      setState(() => remaining = event);
    }).onError((err) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
                title: const Center(child: Text('Atenção!!')),
                content: Text(err.message, textAlign: TextAlign.center),
              ));
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  String fmt(int num) {
    return num.toString().padLeft(2, '0');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Falta quanto tempo pro rolê?'),
        backgroundColor: currentColor,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Falta quanto tempo pro rolê?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      role.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Hora do rolê',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      role.time.fmtHumanDateTime,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          decoration: TextDecoration.underline),
                    ),
                    const SizedBox(height: 50),
                    const Text(
                      'Tempo restante',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 46,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      [
                        if (remaining.inDays > 0)
                          '${remaining.inDays % 31}dias',
                        if (remaining.inHours > 0) '${remaining.inHours % 24}h',
                        '${remaining.inMinutes % 60}min',
                        '${remaining.inSeconds % 60}s'
                      ].join(", "),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '(${AppDate.create(
                        day: remaining.inDays % 24,
                        hour: remaining.inHours % 24,
                        minute: remaining.inMinutes % 60,
                        second: remaining.inSeconds % 60,
                      ).fmtTime})',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Stream<Duration> _getRemainingTime() async* {
    final roleTime = role.time;
    final _targetTime = DateTime(
      roleTime.year,
      roleTime.month,
      roleTime.day,
      roleTime.hour,
      roleTime.minute,
      roleTime.second,
    );
    while (true) {
      if (isRunning) {
        final _difference = _targetTime.difference(DateTime.now());
        if (_difference.isNegative) {
          if (_difference.abs().inHours >= 1) {
            throw const HoraDoRoleException('Hora do rolê já passou!');
          } else {
            throw const HoraDoRoleException(
              '🎈🎈🎈🥳🥳 Tá na hora do rolê!!! 🥳🥳🎈🎈🎈\n',
            );
          }
        }
        yield _difference;
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}

class HoraDoRoleException implements Exception {
  const HoraDoRoleException(this.message);
  final String message;
}
