import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ConnectionError extends StatelessWidget {
  final Function() onRefresh;

  const ConnectionError({required this.onRefresh, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Lottie.asset(
              'assets/animations/connecttion-failed.json',
              width: MediaQuery.of(context).size.width * 0.6,
              fit: BoxFit.contain,
            ),
          ),
          const Center(
              child: Text(
            "Potrebno je refreshat",
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          )),
          Padding(
            padding: const EdgeInsets.only(top: 25.0),
            child: FloatingActionButton(
              onPressed: () => onRefresh(),
              child: const Text("Refesh"),
            ),
          ),
        ],
      ),
    ));
  }
}
