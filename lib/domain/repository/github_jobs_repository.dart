import 'dart:convert';

import 'package:dev_jobs_bloc/domain/model/models.dart';
import 'package:http/http.dart' as http;

class GithubJobsRepository {
  Future<List<JobEntity>> searchJob(String devPosition, String location) async {
    final String url =
        'https://jobs.github.com/positions.json?description=$devPosition&location=$location';
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      Iterable data = List.from(json.decode(response.body));
      List<JobEntity> jobs =
          data.map((json) => JobEntity.fromJson(json)).toList();
      return jobs;
    } else {
      return throw Exception("Unable to connect server");
    }
  }
}
