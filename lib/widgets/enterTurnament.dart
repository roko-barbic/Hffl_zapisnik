import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class EnterTurnament extends StatefulWidget {
  const EnterTurnament({super.key});
  @override
  State<EnterTurnament> createState() => _EnterTurnamentState();
}

class _EnterTurnamentState extends State<EnterTurnament> {
  TextEditingController turnamentNameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isSelectedTime = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
        isSelectedTime = true;
      });
  }

  void createTurnament() async {
    print('create tournament ' + selectedDate.toUtc().toIso8601String());
    var url = Uri.https('hfflzapisnik.azurewebsites.net', '/newTournament');
    Map body = {
      "name": turnamentNameController.text,
      "date": selectedDate.toUtc().toIso8601String()
    };
    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(body),
      );
      if (response.statusCode == 200) {
        print('radi tournament ');
        Navigator.of(context).pop();
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
          height: MediaQuery.of(context).size.height * 0.4,
          child: Column(children: [
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.8,
              child: TextField(
                controller: turnamentNameController,
                decoration: const InputDecoration(
                  labelText: 'Ime turnira:',
                  hintText: 'Unesite ime turnira',
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: const Text(
                'Select date',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
            isSelectedTime
                ? Text(
                    "Odabrano vrijeme održavanja turnira: ${selectedDate.toLocal()}")
                // .split(' ')[0])
                : const Text('Niste još odabrali vrijeme.'),
            const SizedBox(
              height: 15,
            ),
            FloatingActionButton(
              onPressed: (() => createTurnament()),
              child: const Icon(Icons.add),
            )
          ])),
    );
  }
}
