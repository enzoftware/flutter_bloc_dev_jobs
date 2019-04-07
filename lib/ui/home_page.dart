import 'package:dev_jobs_bloc/bloc/github_jobs_bloc.dart';
import 'package:dev_jobs_bloc/domain/repository/github_jobs_repository.dart';
import 'package:dev_jobs_bloc/ui/home_page_events.dart';
import 'package:dev_jobs_bloc/ui/home_page_state.dart';
import 'package:dev_jobs_bloc/ui/job_card.dart';
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
    _homePageBloc = HomePageBloc(repository: GithubJobsRepository());
  }

  @override
  void dispose() {
    super.dispose();
    _homePageBloc.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchMargin = 80.0;

    return BlocProvider<HomePageBloc>(
      bloc: _homePageBloc,
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: searchMargin),
              child: BlocBuilder<HomePageEvent, HomePageState>(
                bloc: _homePageBloc,
                builder: (BuildContext context, HomePageState state) {
                  if (state is HomePageStateDefault) {
                    return Center(
                      child: Text(
                        'Start searching for a job\n Right now!',
                        textAlign: TextAlign.center,
                        style:
                        TextStyle(fontSize: 24.0, color: Colors.blueGrey),
                      ),
                    );
                  }

                  if (state is HomePageStateSearching) {
                    searchElevation = 0;
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  if (state is HomePageStateError) {
                    return Center(
                      child: Text(
                        'Connection error!',
                        style: TextStyle(color: Colors.red, fontSize: 24.0),
                      ),
                    );
                  }

                  if (state is HomePageStateSearched) {
                    if (state.jobs.length == 0) {
                      return Center(
                        child: Text('No results'),
                      );
                    }

                    return NotificationListener(
                      onNotification: (t) {
                        if (t is ScrollUpdateNotification) {
                          print('Delta : {$t.scrollDelta}');
                          if (t.scrollDelta < 0.0 && searchElevation != 0) {
                            setState(() {
                              searchElevation = 0.0;
                            });
                          } else if (t.scrollDelta > 0.0 &&
                              searchElevation != 8) {
                            searchElevation = 30.0;
                          }
                        }
                      },
                      child: ListView.builder(
                        itemCount: state.jobs.length,
                        itemBuilder: (context, index) {
                          return JobCard(
                            jobEntity: state.jobs.elementAt(index),
                          );
                        },
                      ),
                    );
                  }
                },
              ),
            ),
            AnimatedContainer(
              curve: Curves.fastOutSlowIn,
              duration: Duration(milliseconds: 800),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 60,
              margin: EdgeInsets.only(top: 36, left: 12, right: 12),
              padding: EdgeInsets.only(top: 4, left: 16, right: 16),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26, blurRadius: searchElevation)
                  ]),
              child: TextField(
                onSubmitted: (query) {
                  var position = _textEditingController.text;
                  _homePageBloc
                      .dispatch(HomePageEventSearch(devPosition: position));
                },
                controller: _textEditingController,
                decoration: InputDecoration(
                    hintText: 'Search', border: InputBorder.none),
              ),
            )
          ],
        ),
      ),
    );
  }
}
