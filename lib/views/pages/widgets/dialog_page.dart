import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class DialogPage<T> extends Page<T> {
  final Offset? anchorPoint;
  final Color? backgroundColor;
  final bool barrierDismissible;
  final String? barrierLabel;
  final bool useSafeArea;
  final CapturedThemes? themes;
  final WidgetBuilder builder;
  const DialogPage({
    required this.builder,
    this.anchorPoint,
    this.backgroundColor = Colors.black,
    this.barrierDismissible = true,
    this.barrierLabel,
    this.useSafeArea = true,
    this.themes,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });
  @override
  Route<T> createRoute(BuildContext context) => DialogRoute<T>(
        context: context,
        settings: this,
        builder: (context) => Dialog(
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 18,
          ),
          alignment: Alignment.center,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: builder(context),
          // backgroundColor: colorChanger(
          //     context: context,
          //     dark: globals.colorTxt.darken(14),
          //     light: globals.lightBG),
        ).animate().scale(duration: const Duration(milliseconds: 180)).fade(),
        barrierDismissible: true,
        barrierLabel: barrierLabel,
        useSafeArea: true,
        themes: themes,
      );
}
