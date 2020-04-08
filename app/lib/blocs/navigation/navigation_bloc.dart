import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

abstract class NavigatorEvent {}

class Pop extends NavigatorEvent {}

class PushNamed extends NavigatorEvent {
  final String route;

  PushNamed(this.route);
}

class NavigatorBloc extends Bloc<NavigatorEvent, dynamic> {
  final GlobalKey<NavigatorState> navigatorKey;

  NavigatorBloc({@required this.navigatorKey});

  @override
  dynamic get initialState => 0;

  @override
  Stream<dynamic> mapEventToState(NavigatorEvent event) async* {
    if (event is Pop) {
      navigatorKey.currentState.pop();
    } else if (event is PushNamed) {
      navigatorKey.currentState.pushNamed(event.route);
    }
  }
}
