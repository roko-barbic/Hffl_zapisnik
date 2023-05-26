import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/eventClasses/eventTD.dart';
import 'package:hffl_zapisnik/classes/player.dart';
import 'package:provider/provider.dart';

import '../providers/events.dart';

class EnterEventSc extends StatefulWidget {
  const EnterEventSc({super.key});
  static const routeName = '/enter-event';
  @override
  State<EnterEventSc> createState() => _EnterEventScState();
}

class _EnterEventScState extends State<EnterEventSc> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  late String _dropDownValue;
  late bool isEventTypeSelected;

  late String playerTDName;
  late String playerPassName;

  late Player playerPass;
  late Player playerTD;
  late Player playerSafety;

  Widget _conditionalWidget = Container();

  //Odabir vrste događaja
  void chooseTypeOfEvent(String? selectedValue) {
    setState(() {
      _dropDownValue = selectedValue!;
      isEventTypeSelected = true;
      if (_dropDownValue == 'touchdown') {
        _conditionalWidget = Container(
            height: MediaQuery.of(context).size.height * 0.75,
            width: double.infinity,
            child: Column(
              children: [
                const Text('Igrač pass: '),
                TextField(
                  controller: controller1,
                  onChanged: (value) => {playerPassName = value},
                ),
                const Text('Igrač catch: '),
                TextField(
                  controller: controller2,
                  onChanged: (value) => {playerTDName = value},
                ),
                FloatingActionButton(
                  onPressed: () => createEventTD(),
                  child: const Text('Save'),
                )
              ],
            ));
      } else if (_dropDownValue == 'extrapoint2') {
        _conditionalWidget = Container(
          child: Text('You selected extrapoint2!'),
        );
      } else if (_dropDownValue == 'extrapoint4') {
        _conditionalWidget = Container(
          child: Text('You selected extrapoint4!'),
        );
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    _dropDownValue = '';
    isEventTypeSelected = false;
    _conditionalWidget = Container(
      child: Text('Potrebno je odabrati vrstu događaja'),
    );
    super.initState();
  }

  void createEventTD() {
    playerTD = Player(name: playerTDName, height: 150);
    playerPass = Player(name: playerPassName, height: 149);
    TouchDown touchdown =
        TouchDown(touchdownCatch: playerTD, touchdownPass: playerPass);
    Provider.of<EventsList>(context, listen: false).add(touchdown);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        'Unos korisnika',
      )),
      body: Column(
        children: [
          DropdownButton(
            items: const [
              DropdownMenuItem(
                child: Text('Touchdown'),
                value: 'touchdown',
              ),
              DropdownMenuItem(
                child: Text('Extrapoint 2'),
                value: 'extrapoint2',
              ),
              DropdownMenuItem(
                child: Text('Extrapoint4'),
                value: 'extrapoint4',
              ),
            ],
            onChanged: chooseTypeOfEvent,
            //value: isEventTypeSelected ? _dropDownValue : 'odaberi',
          ),
          isEventTypeSelected ? _conditionalWidget : Text('Nisi odabrao vrstu'),
        ],
      ),
    );
  }
}
