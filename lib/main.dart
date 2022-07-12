import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/cubit/bloc_observer.dart';
import 'screens/tasks_screen.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(const MyApp());
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "new ",
      home: Scaffold(body: TaskScreens()),
    );
  }
}
