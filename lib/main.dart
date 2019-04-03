import 'package:bloc/bloc.dart';
import 'package:dev_jobs_bloc/ui/home_page.dart';
import 'package:flutter/material.dart';

class BlocMainDelegate extends BlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition);
  }

  @override
  void onError(Object error, StackTrace stacktrace) {
    print(error);
  }
}

void main() {
  BlocSupervisor().delegate = BlocMainDelegate();
  runApp(GithubJobsApp());
}

class GithubJobsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Github Jobs - BLoC pattern',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
