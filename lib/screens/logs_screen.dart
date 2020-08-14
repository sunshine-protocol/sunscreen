import 'package:flutter/material.dart';
import 'package:sunshine/sunshine.dart';
import 'package:xterm/frontend/terminal_view.dart';
import 'package:xterm/xterm.dart';

class LoggerScreen extends StatefulWidget {
  @override
  _LoggerScreenState createState() => _LoggerScreenState();
}

class _LoggerScreenState extends State<LoggerScreen> {
  LoggerService _loggerService;
  @override
  void initState() {
    super.initState();
    _loggerService = GetIt.I.get<LoggerService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(title: 'Logger'),
      body: StreamBuilder<void>(
        stream: _loggerService.stream,
        builder: (context, snapshot) {
          final _terminal = Terminal(
            onInput: (_) {},
          );
          _loggerService.items.forEach(_terminal.write);
          return TerminalView(
            terminal: _terminal,
          );
        },
      ),
    );
  }
}
