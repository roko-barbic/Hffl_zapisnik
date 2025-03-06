import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BouncingBallProgressIndicator extends StatefulWidget {
  const BouncingBallProgressIndicator({super.key});

  @override
  State<BouncingBallProgressIndicator> createState() => _BouncingBallProgressIndicatorState();
}

class _BouncingBallProgressIndicatorState extends State<BouncingBallProgressIndicator>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 30), // Adjust to match your animation’s natural duration
    )..repeat(); // Start looping immediately
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/bouncing-american-football.json',
        controller: _controller,
        width: 150,
        height: 150,
        fit: BoxFit.contain,
        repeat: true, // Ensure looping
        onLoaded: (composition) {
          // Set duration to match the animation file’s length
          _controller.duration = composition.duration;
          _controller.repeat(); // Restart loop if needed
        },
      ),
    );
  }
}