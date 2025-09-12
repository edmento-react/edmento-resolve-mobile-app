import 'dart:io';
import 'dart:math';

import 'package:edmentoresolve/core/widgets/cards/glass_container.dart';
import 'package:flutter/material.dart';
import 'package:liquid_glass_renderer/liquid_glass_renderer.dart';

class GlassButton extends StatelessWidget {
  const GlassButton({super.key, required this.onPressed, required this.child});

  final VoidCallback? onPressed;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed, // won't do anything since null
      child: Container(
        child: Platform.isAndroid
            ? GlassContainer(
                width: 45,
                height: 45,
                borderRadius: 30,
                child: child,
              )
            : LiquidGlass(
                glassContainsChild: false,

                settings: LiquidGlassSettings(
                  blur: 5,
                  thickness: 15,
                  glassColor: Colors.white.withValues(alpha: 0.0),
                  lightAngle: 0.8 * pi,
                  blend: 30,
                  chromaticAberration: 0.8,
                ),
                shape: LiquidRoundedSuperellipse(
                  borderRadius: Radius.circular(100),
                ),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.transparent,
                  ),
                  child: Center(child: child),
                ),
              ),
      ),
    );
  }
}
