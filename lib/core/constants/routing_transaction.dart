import 'package:flutter/material.dart';

/// Enum for supported transition types.
enum TransitionType { leftToRight, rightToLeft, bottomToTop, fade, scale }

/// Slide transition: Left to Right.
Widget slideLeftToRightTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final tween = Tween(
    begin: const Offset(-1.0, 0.0),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeInOut));
  return SlideTransition(position: animation.drive(tween), child: child);
}

/// Slide transition: Right to Left.
Widget slideRightToLeftTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final tween = Tween(
    begin: const Offset(1.0, 0.0),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeInOut));
  return SlideTransition(position: animation.drive(tween), child: child);
}

/// Slide transition: Bottom to Top.
Widget slideBottomToTopTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final tween = Tween(
    begin: const Offset(0.0, 1.0),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeInOut));
  return SlideTransition(position: animation.drive(tween), child: child);
}

/// Slide transition: Top to Bottom.
Widget slideTopToBottomTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final tween = Tween(
    begin: const Offset(0.0, -1.0),
    end: Offset.zero,
  ).chain(CurveTween(curve: Curves.easeInOut));
  return SlideTransition(position: animation.drive(tween), child: child);
}

/// Fade transition.
Widget fadeTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  return FadeTransition(opacity: animation, child: child);
}

/// Scale (zoom) transition.
Widget scaleTransition(
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  final tween = Tween(
    begin: 0.8,
    end: 1.0,
  ).chain(CurveTween(curve: Curves.easeInOut));
  return ScaleTransition(scale: animation.drive(tween), child: child);
}

/// Returns the transition widget corresponding to the given [TransitionType].
Widget getTransitionByType(
  TransitionType type,
  BuildContext context,
  Animation<double> animation,
  Animation<double> secondaryAnimation,
  Widget child,
) {
  switch (type) {
    case TransitionType.leftToRight:
      return slideLeftToRightTransition(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    case TransitionType.rightToLeft:
      return slideRightToLeftTransition(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    case TransitionType.bottomToTop:
      return slideBottomToTopTransition(
        context,
        animation,
        secondaryAnimation,
        child,
      );
    case TransitionType.fade:
      return fadeTransition(context, animation, secondaryAnimation, child);
    case TransitionType.scale:
      return scaleTransition(context, animation, secondaryAnimation, child);
  }
}
