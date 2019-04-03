import 'package:dev_jobs_bloc/bloc/github_jobs_bloc.dart';
import 'package:dev_jobs_bloc/domain/repository/github_jobs_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  HomePageBloc _homePageBloc;
  TextEditingController _textEditingController;

  double searchElevation = 1;


  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController();
    _homePageBloc = HomePageBloc(
        repository: GithubJobsRepository()
    );
  }


  @override
  void dispose() {
    super.dispose();
    _homePageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomePageBloc>(
      bloc: _homePageBloc,
      child: Scaffold(
        body: Stack(),
      ),
    );
  }
}
