import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/eventClasses/event.dart';
import 'package:hffl_zapisnik/widgets/torunamentsGrid.dart';
import './providers/tournaments.dart';
import 'package:hffl_zapisnik/screens/rankingScreen.dart';
import 'package:hffl_zapisnik/widgets/clubsGrid.dart';
import '../providers/clubs.dart';
import '../providers/events.dart';
import '/services/mysql.dart';
import 'package:provider/provider.dart';
import './screens/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './services/mysql.dart';
import './screens/enterEvent.dart';
import './widgets/eventsGrid.dart';

// void main() {
//   runApp(const MyApp());
// }
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool isLoggedIn =
      prefs.getBool('isLoggedIn') ?? false; // Default to false if not found
  print("probjera prefsa za pocinanje app" +
      prefs.getBool('isLoggedIn').toString());
  runApp(MyApp(isLoggedIn: isLoggedIn));
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  MyApp({required this.isLoggedIn, Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      //create: (context) => UsersList(),
      providers: [
        ChangeNotifierProvider<EventsList>(create: (context) => EventsList()),
        ChangeNotifierProvider<ClubsList>(create: (context) => ClubsList()),
        ChangeNotifierProvider<TournamentsList>(
            create: (context) => TournamentsList())
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          //fontFamily: '';
        ),
        home: MyHomePage(
          title: 'HFFL zapisnik',
          isLoggedIn: isLoggedIn,
        ),
        routes: {
          EnterEventSc.routeName: (context) => const EnterEventSc(),
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({super.key, required this.title, required this.isLoggedIn});
  final String title;
  bool isLoggedIn;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var club = '  ';
  // bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<bool> fetchLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }

  Future<void> checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    bool? loggedIn = prefs.getBool('isLoggedIn');
    print("probjera prefsa" + loggedIn.toString());
    setState(() {
      // Update the parent widget's property using widget.isLoggedIn
      widget.isLoggedIn = loggedIn!;
    });
  }

  Future<void> logOutAdmin() async {
    final _prefs = await SharedPreferences.getInstance();
    await _prefs.setBool('isLoggedIn', false);

    print(
        "probjera prefsa za logout" + _prefs.getBool('isLoggedIn').toString());
    setState(() {
      // Update the parent widget's property using widget.isLoggedIn
      widget.isLoggedIn = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title),
              actions: [
                FutureBuilder<bool>(
                  future: fetchLoginStatus(), // Use the future here
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      // Handle the loading state if needed
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      // Handle errors
                      return Text('Error: ${snapshot.error}');
                    } else {
                      // Check the isLoggedIn status
                      bool isLoggedIn = snapshot.data ?? false;

                      return !isLoggedIn
                          ? IconButton(
                              icon: const Icon(Icons.lock_person),
                              onPressed: () {
                                // Add your button's action here
                                // For example, navigate to a new screen
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        (LogInScreen()), // Replace with your actual login screen widget
                                  ),
                                );
                              },
                            )
                          : IconButton(
                              icon: const Icon(Icons.logout_sharp),
                              onPressed: () {
                                // Add your button's action here
                                // For example, navigate to a new screen
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Logout'),
                                      content: Text('Do you want to Logout?'),
                                      actions: <Widget>[
                                        Row(children: [
                                          TextButton(
                                            child: Text('YES'),
                                            onPressed: () {
                                              logOutAdmin();
                                              Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      MyHomePage(
                                                    title: 'HFFL zapisnik',
                                                    isLoggedIn:
                                                        false, // Set isLoggedIn to true after successful login
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                          TextButton(
                                            child: Text('NO'),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                        ]),
                                      ],
                                    );
                                  },
                                );
                              },
                            );
                    }
                  },
                ),
              ],
              bottom: const TabBar(tabs: [
                Tab(
                  child: Text("Ljestvica"),
                ),
                Tab(
                  child: Text("Turniri"),
                ),
              ]),
            ),
            body: const TabBarView(children: [
              RankingScreen(),
              // Text("BOOOK")
              TournamentsGrid()
            ])),
      ),
    );
  }
}
