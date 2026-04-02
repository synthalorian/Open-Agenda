import 'package:flutter/material.dart';

/// Animates a number counting up from 0 to [value].
class AnimatedCounter extends StatelessWidget {
  final int value;
  final String suffix;
  final TextStyle? style;
  final Duration duration;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.suffix = '',
    this.style,
    this.duration = const Duration(milliseconds: 800),
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value.toDouble()),
      duration: duration,
      curve: Curves.easeOutCubic,
      builder: (context, val, _) {
        return Text(
          '${val.toInt()}$suffix',
          style: style,
        );
      },
    );
  }
}
