import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:sunshine/models/models.dart';

@injectable
class GithubService {
  GithubService() : _httpClient = http.Client();

  final http.Client _httpClient;

  Future<GithubIssue> getIssue(
    String owner,
    String repo,
    String number,
  ) async {
    final url = 'https://api.github.com/repos/$owner/$repo/issues/$number';
    final result = await _httpClient.get(url);
    print(result.statusCode);
    print(result.body);
    return GithubIssue.fromRawJson(result.body);
  }
}
