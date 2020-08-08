import 'package:http_extensions/http_extensions.dart';
import 'package:http_extensions_cache/http_extensions_cache.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;
import 'package:sunshine/models/models.dart';

@lazySingleton
@injectable
class GithubService {
  GithubService()
      : _httpClient = ExtendedClient(
          // ignore: avoid_as
          inner: http.Client() as http.BaseClient,
          extensions: [
            CacheExtension(
              defaultOptions: CacheOptions(
                expiry: const Duration(hours: 1),
                forceUpdate: false,
                forceCache: false,
                ignoreCache: false,
                returnCacheOnError: false,
                store: MemoryCacheStore(),
              ),
            ),
          ],
        );

  final ExtendedClient _httpClient;

  Future<GithubIssue> getIssue(
    String owner,
    String repo,
    int number,
  ) async {
    final url = 'https://api.github.com/repos/$owner/$repo/issues/$number';
    final result = await _httpClient.get(url);
    return GithubIssue.fromRawJson(result.body);
  }
}
