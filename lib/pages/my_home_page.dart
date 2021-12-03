import 'dart:async';

import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final Color currentColor = Colors.blue;

  final int _horasDoRole = 18;
  final int _minutosDoRole = 00;
  final int _segundosDoRole = 00;

  String seconds = '00';
  String minutes = '00';
  String hours = '00';

  bool get isRunning => true;

  @override
  initState() {
    super.initState();
    _getRemainingTime().listen((event) {
      setState(() {
        hours = fmt(event[0]);
        minutes = fmt(event[1]);
        seconds = fmt(event[2]);
      });
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
        title: const Text('Falta quanto tempo pro role?'),
        backgroundColor: currentColor,
      ),
      body: Center(
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
                    '${fmt(_horasDoRole)}:${fmt(_minutosDoRole)}:${fmt(_segundosDoRole)}',
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
                    '$hours h, $minutes min e $seconds s',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '($hours:$minutes:$seconds)',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Stream<List<int>> _getRemainingTime() async* {
    final _now = DateTime.now();
    final _targetTime = DateTime(
      _now.year,
      _now.month,
      _now.day,
      _horasDoRole,
      _minutosDoRole,
      _segundosDoRole,
    );
    while (true) {
      if (isRunning) {
        final _difference = _targetTime.difference(DateTime.now());
        if (_difference.isNegative) {
          throw const HoraDoRoleException('Hora do rolê já passou!');
        }
        final diffStr = _difference.toString().split(':');
        yield [
          int.parse(diffStr[0]),
          int.parse(diffStr[1]),
          int.parse(diffStr[2].substring(0, diffStr[2].indexOf('.')))
        ];
      }
      await Future.delayed(const Duration(seconds: 1));
    }
  }
}

class HoraDoRoleException implements Exception {
  const HoraDoRoleException(this.message);
  final String message;
}
