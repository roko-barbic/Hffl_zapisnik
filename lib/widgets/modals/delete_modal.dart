import 'package:flutter/material.dart';

class DeleteModal extends StatelessWidget {
  final Function() onDelete;
  final int id;
  final String warningMessage;
  final String title;

  const DeleteModal(
      {required this.id,
      required this.onDelete,
      required this.warningMessage,
      required this.title,
      super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(warningMessage.replaceAll('%s', id.toString())),
      actions: <Widget>[
        TextButton(
            child: const Text('Da'),
            onPressed: () async {
              onDelete();
              Navigator.of(context).pop();
            }),
        TextButton(
          child: const Text('Ne'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
