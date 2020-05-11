import 'dart:io';
import 'package:path_provider/path_provider.dart' as path_provider;

class PathProviderService {
  PathProviderService({
    Directory applicationDocumentsDirectory,
  }) : _applicationDocumentsDirectory = applicationDocumentsDirectory;

  static Future<PathProviderService> create() async {
    return PathProviderService(
      applicationDocumentsDirectory:
          await path_provider.getApplicationDocumentsDirectory(),
    );
  }

  final Directory _applicationDocumentsDirectory;

  Directory get applicationDocumentsDirectory => _applicationDocumentsDirectory;
}
