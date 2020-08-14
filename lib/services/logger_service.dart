import 'dart:async';

import 'package:injectable/injectable.dart';
import 'package:frusty_logger/frusty_logger.dart';

@lazySingleton
class LoggerService {
  List<String> items = [];
  StreamController<void> _streamController;
  void _onLogEvent(String event) {
    items.add('$event\r\n');
    _streamController.add(null);
  }

  void listenToLogs() {
    FrustyLogger.addListener(_onLogEvent);
    _streamController = StreamController.broadcast();
  }

  Stream<void> get stream => _streamController.stream;
}
