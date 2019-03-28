import 'package:dev_jobs_bloc/domain/model/models.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class HomePageState extends Equatable {
  HomePageState([List props = const []]) : super(props);
}

class HomePageStateDefault extends HomePageState {
  @override
  String toString() => 'HomePageStateDefault';
}

class HomePageStateSearching extends HomePageState {
  @override
  String toString() => 'HomePageStateSearching';
}

class HomePageStateError extends HomePageState {
  final String message;

  HomePageStateError({this.message});

  @override
  String toString() => 'HomePageStateError';
}

class HomePageStateSearched extends HomePageState {
  final List<JobEntity> jobs;

  HomePageStateSearched({this.jobs});

  @override
  String toString() => 'HomePageStateSearched';
}
