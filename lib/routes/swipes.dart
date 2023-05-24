import 'package:flutter/material.dart';
import 'package:genipaws/constants.dart';

class SlideToLeftPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  SlideToLeftPageRoute({required this.child})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              child,
          transitionDuration: const Duration(
              milliseconds: Constants.transitionDurationOfSwipeForLeft),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(-1, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}

class SlideToRightPageRoute<T> extends PageRouteBuilder<T> {
  final Widget child;

  SlideToRightPageRoute({required this.child})
      : super(
          pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) =>
              child,
          transitionDuration: const Duration(
              milliseconds: Constants.transitionDurationOfSwipeForLeft),
          transitionsBuilder: (BuildContext context,
              Animation<double> animation,
              Animation<double> secondaryAnimation,
              Widget child) {
            return SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(1, 0.0),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            );
          },
        );
}
