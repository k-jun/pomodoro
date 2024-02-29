import 'package:flutter/material.dart';
import 'package:pomodoro/pomodoro_status.dart';
import 'package:pomodoro/pomodoro_timer.dart';
import 'package:pomodoro/pomodoro_button.dart';
import 'package:pomodoro/pomodoro_indicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PomodoroBloc(ticker: Ticker()),
      child: Scaffold(
        backgroundColor: Colors.red[400],
        body: SafeArea(
          child: Container(
            margin: EdgeInsets.fromLTRB(30, 25, 30, 20),
            child: Column(
              children: <Widget>[
                Expanded(flex: 8, child: PomodoroStatus()),
                Expanded(flex: 48, child: PomodoroTimer()),
                Expanded(flex: 24, child: PomodoroIndicator()),
                Expanded(flex: 18, child: PomodoroButton()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
