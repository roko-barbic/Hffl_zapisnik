import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/eventClasses/event.dart';
import 'package:hffl_zapisnik/widgets/clubsGrid.dart';
import '../providers/clubs.dart';
import '../providers/events.dart';
import '/services/mysql.dart';
import 'package:provider/provider.dart';

import './services/mysql.dart';
import './screens/enterEvent.dart';
import './widgets/eventsGrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //create: (context) => UsersList(),
      providers: [
        ChangeNotifierProvider<EventsList>(create: (context) => EventsList()),
        ChangeNotifierProvider<ClubsList>(create: (context) => ClubsList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //fontFamily: '';
        ),
        home: const MyHomePage(title: 'HFFL zapisnik'),
        routes: {
          EnterEventSc.routeName: (context) => const EnterEventSc(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var club = '  ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Container(
            padding: const EdgeInsets.only(top: 10),
            width: MediaQuery.of(context).size.width * 95,
            height: 500,
            child: const Center(child: ClubsGrid()),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (() =>
            Navigator.of(context).pushNamed(EnterEventSc.routeName)),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
