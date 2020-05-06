import 'package:flutter/material.dart';
import 'package:fluid_layout/fluid_layout.dart';

class FluidScaffold extends StatelessWidget {
  final Widget appBar;
  final Widget body;

  FluidScaffold({@required this.appBar, @required this.body});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: this.appBar,
      body: FluidLayout(
        child: Fluid(
          child: SafeArea(
            child: this.body,
          ),
        ),
      ),
    );
  }
}

class PageWidget extends StatelessWidget {
  final List<Widget> content;
  final List<Widget> footer;

  PageWidget({@required this.content, @required this.footer});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: this.content,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: this.footer,
          ),
        ],
      ),
    );
  }
}

class TwoRowsOrColumn extends StatelessWidget {
  final List<Widget> left;
  final List<Widget> right;

  TwoRowsOrColumn({@required this.left, @required this.right});

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.of(context).orientation == Orientation.portrait) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: this.left + this.right,
      );
    } else {
      return Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: this.left,
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: this.right,
            ),
          ),
        ],
      );
    }
  }
}
