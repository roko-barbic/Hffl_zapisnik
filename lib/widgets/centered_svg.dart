import 'package:flutter/material.dart';

class CenteredSvg extends StatelessWidget {
  const CenteredSvg({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Image.asset(
          'assets/images/extrapoint_logo_transparent.png',
          width: 39,
          height: 39,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
