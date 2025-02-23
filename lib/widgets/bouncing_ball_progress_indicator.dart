import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class BouncingBallProgressIndicator extends StatelessWidget {
  const BouncingBallProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Lottie.asset(
        'assets/animations/bouncing-american-football.json',
        width: 150,
        height: 150,
        fit: BoxFit.contain,
      ),
    );
  }
}
