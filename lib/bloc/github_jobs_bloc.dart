import 'package:bloc/bloc.dart';
import 'package:dev_jobs_bloc/domain/repository/github_jobs_repository.dart';
import 'package:dev_jobs_bloc/ui/home_page_events.dart';
import 'package:dev_jobs_bloc/ui/home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  final GithubJobsRepository repository;

  HomePageBloc(this.repository);

  @override
  HomePageState get initialState => HomePageStateDefault();

  @override
  Stream<HomePageState> mapEventToState(
      HomePageState currentState, HomePageEvent event) async* {
    if (event is HomePageEventSearch) {
      yield* _mapSearchJobsState(event);
    }
  }

  Stream<HomePageState> _mapSearchJobsState(HomePageEventSearch event) async* {
    try {
      yield HomePageStateSearching();
      var result = await repository.searchJob(event.devPosition, '');
      yield HomePageStateSearched(jobs: result);
    } catch (e) {
      yield HomePageStateError();
    }
  }
}
