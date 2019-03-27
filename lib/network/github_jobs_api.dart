import 'package:dev_jobs_bloc/domain/model/models.dart';
import 'package:dev_jobs_bloc/domain/repository/github_jobs_repository.dart';

class GithubJobsApi {
  final githubJobsService = GithubJobsRepository();

  Future<List<JobEntity>> searchJob(String devPosition, String location) {
    return githubJobsService.searchJob(devPosition, location);
  }
}
