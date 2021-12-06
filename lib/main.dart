import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend_challenge_2/src/screens/list.dart';
import 'package:frontend_challenge_2/src/screens/week.dart';

Future main() async {
  await dotenv.load(fileName: '.env');
  runApp(const DieselBankChallendApp());
}

class DieselBankChallendApp extends StatelessWidget {
  const DieselBankChallendApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Diesel Bank Challenge',
        theme: ThemeData(
          primarySwatch: Colors.grey,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => const ScreenWeatherList(),
          '/week': (context) => const ScreenWeatherWeek(),
        });
  }
}
