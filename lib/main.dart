import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:hffl_zapisnik/classes/eventClasses/event.dart';
import 'package:hffl_zapisnik/cubit/app_bloc_observer.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/views/clubs_ranking_screen.dart';
import 'package:hffl_zapisnik/views/tournaments_screen.dart';
import 'package:hffl_zapisnik/widgets/enter_tournament.dart';
import 'package:hffl_zapisnik/widgets/torunamentsGrid.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import './providers/tournaments.dart';
import 'package:hffl_zapisnik/screens/rankingScreen.dart';
import 'package:hffl_zapisnik/widgets/clubsGrid.dart';
import '../providers/clubs.dart';
import '../providers/events.dart';
import '/services/mysql.dart';
import 'package:bloc/bloc.dart';
import 'package:provider/provider.dart';
import './screens/LogIn.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/foundation.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';

// void main() {
//   runApp(const MyApp());
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   final prefs = await SharedPreferences.getInstance();
//   bool isLoggedIn =
//       prefs.getBool('isLoggedIn') ?? false; // Default to false if not found
//   print("probjera prefsa za pocinanje app" +
//       prefs.getBool('isLoggedIn').toString());
//   runApp(MyApp(isLoggedIn: isLoggedIn));
// }

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   //Bloc.observer = const ClubsBlocObserver();
//   HydratedBloc.storage = await HydratedStorage.build(
//     storageDirectory: kIsWeb
//         ? HydratedStorageDirectory.web
//         : HydratedStorageDirectory((await getTemporaryDirectory()).path),
//   );
//   runApp(MyApp(hfflRepository: HfflRepository(), isLoggedIn: false,));
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Build the correct HydratedStorage directory based on the platform.
  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  Bloc.observer = AppBlocObserver();

  HydratedBloc.storage = storage;

  runApp(MyApp(
    hfflRepository: HfflRepository(),
    isLoggedIn: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {required this.isLoggedIn,
      required HfflRepository hfflRepository,
      Key? key})
      : _hfflRepository = hfflRepository,
        super(key: key);

  final bool isLoggedIn;
  final HfflRepository _hfflRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      //create: (context) => UsersList(),
      // providers: [
      //   ChangeNotifierProvider<EventsList>(create: (context) => EventsList()),
      //   ChangeNotifierProvider<ClubsList>(create: (context) => ClubsList()),
      //   ChangeNotifierProvider<TournamentsList>(
      //       create: (context) => TournamentsList())
      // ],
      providers: [
        BlocProvider<ClubsCubit>(
          create: (context) {
            final cubit = ClubsCubit(_hfflRepository);
            cubit
                .fetchClubsInfo(); // Fetch clubs as soon as the cubit is created
            return cubit;
          },
        ),
        BlocProvider<TournamentCubit>(
          create: (context) {
            final cubit = TournamentCubit(_hfflRepository);
            cubit
                .fetchTournaments(); // Fetch clubs as soon as the cubit is created
            return cubit;
          },
        ),
        BlocProvider<GameCubit>(create: (context) {
          final cubit = GameCubit(_hfflRepository);
          return cubit;
        })
      ],
      child: const HfflAppView(),
      // MaterialApp(
      //   title: 'Flutter Demo',
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //     //fontFamily: '';
      //   ),
      //   home: MyHomePage(
      //     title: isLoggedIn ? 'FlagFootballHR Admin' : 'FlagFootballHR',
      //     isLoggedIn: isLoggedIn,
      //   ),
      // ),
    );
  }
}

class HfflAppView extends StatefulWidget {
  const HfflAppView({super.key});

  @override
  _HfflAppViewState createState() => _HfflAppViewState();
}

class _HfflAppViewState extends State<HfflAppView>
    with TickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: Colors.redAccent, // Set primary color to redAccent
        colorScheme: const ColorScheme.light(
          primary: Colors.redAccent,
          // Ensure redAccent is used for primary elements
          secondary: Colors.blueAccent, // Optional: Define a secondary color
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.redAccent, // Ensure AppBar uses redAccent
          foregroundColor: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          // Color for selected tab text/icon
          unselectedLabelColor: Colors.white70,
          // Color for unselected tab text/icon
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.redAccent,
          title: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                "CAFA - zapisnik",
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.white),
              )),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                print('Logout pressed');
              },
            ),
          ],
          bottom: TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            controller: _tabController,
            tabs: const [
              Tab(
                  icon: Text(
                "Poredak",
                style: TextStyle(fontSize: 16),
              )),
              Tab(
                  icon: Text(
                "Turniri",
                style: TextStyle(fontSize: 16),
              )),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: const [
            ClubsRanking(),
            TournamentsScreen(),
          ],
        ),
      ),
    );
  }
}
