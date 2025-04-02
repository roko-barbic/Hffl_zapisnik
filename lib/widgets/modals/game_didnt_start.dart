import 'package:flutter/material.dart';

class GameDidntStartModal extends StatelessWidget {
  const GameDidntStartModal({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Utakmica nije pocela"),
      content: const Text("Pokusajte malo kasnije."),
      actions: <Widget>[
        TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ],
    );
  }
}
