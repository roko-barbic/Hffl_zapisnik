import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:hffl_zapisnik/classes/eventClasses/event.dart';
import 'package:hffl_zapisnik/cubit/app_bloc_observer.dart';
import 'package:hffl_zapisnik/cubit/auth_cubit.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/screens/login_screen.dart';
import 'package:hffl_zapisnik/screens/overview_screen.dart';
import 'package:hffl_zapisnik/views/clubs_ranking_screen.dart';
import 'package:hffl_zapisnik/views/games_screen.dart';
import 'package:hffl_zapisnik/views/tournaments_screen.dart';
import 'package:hffl_zapisnik/widgets/enter_tournament.dart';
import 'package:hffl_zapisnik/widgets/torunamentsGrid.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:hffl_zapisnik/global_keys.dart';
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
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:dio/dio.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  final String conn = dotenv.env['API_URL'] ?? 'https://default-url.com';
  final Dio client = new Dio(BaseOptions(
    baseUrl: conn,
    connectTimeout: const Duration(seconds: 5),
    receiveTimeout: const Duration(seconds: 5),));
  final authCubit = AuthCubit(HfflApi(conn: conn, client: client));

  authCubit.tokenCheck();

  client.interceptors.add(InterceptorsWrapper(
    onRequest: (options, handler) async {
      final token = await authCubit.getToken();
      if (token != null) {
        options.headers['Authorization'] = 'Bearer $token';
      }
      return handler.next(options);
    },
    onError: (DioException error, handler) async {
      if (error.response?.statusCode == 401) {
        final refreshed = await authCubit.refresh();
        if (refreshed) {
          error.requestOptions.headers['Authorization'] = 'Bearer ${await authCubit.getToken()}';
          return handler.resolve(await client.fetch(error.requestOptions));
        } else {
          final context = navigatorKey.currentContext;
          if(context != null){
            navigatorKey.currentContext?.read<AuthCubit>().logout();
            Navigator.popUntil(context, (route) => route.isFirst || route.settings.name == '/login');
            if (ModalRoute.of(context)?.settings.name != '/login') {
              Navigator.pushReplacementNamed(context, '/login');
            }
          }
        }
      }
      return handler.next(error);
    },
  ));

  final hfflApi = HfflApi(conn: conn, client: client);
  final hfflRepository = HfflRepository(hfflApiClient: hfflApi);

  final storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getTemporaryDirectory(),
  );

  Bloc.observer = AppBlocObserver();

  HydratedBloc.storage = storage;

  runApp(GlobalLoaderOverlay(
    overlayWidgetBuilder: (_) => const Center(
      child: CircularProgressIndicator(
        color: Colors.blue,
        strokeWidth: 6.0,
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    ),
    overlayColor: Colors.black.withOpacity(0.7),
    child: MyApp(
      hfflRepository: hfflRepository,
      authCubit: authCubit,
      isLoggedIn: false,
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp(
      {required this.isLoggedIn,
      required HfflRepository hfflRepository,
        required this.authCubit,
      Key? key})
      : _hfflRepository = hfflRepository,
        super(key: key);

  final bool isLoggedIn;
  final HfflRepository _hfflRepository;
  final AuthCubit authCubit;

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
        }),
        BlocProvider.value(value: authCubit),
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
      navigatorKey: navigatorKey,
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(2, 71, 181, 1.0),
        colorScheme: const ColorScheme.light(
          primary: Color.fromRGBO(2, 71, 181, 1.0),
          secondary: Colors.blueAccent,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromRGBO(2, 71, 181, 1.0),
          foregroundColor: Colors.white,
        ),
        tabBarTheme: const TabBarTheme(
          labelColor: Colors.white,
          // Color for selected tab text/icon
          unselectedLabelColor: Colors.white70,
          // Color for unselected tab text/icon
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) =>BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return state.isLoggedIn ? OverviewScreen() : LoginScreen();
              },
            ),

        /*'/login': (context) => LoginScreen(),
        '/gameScreen': (context) => GamesScreen(tournamentId: tournamentId, tournamentName: tournamentName),
        '/tournamentScreen': (context) => */
      },
    );
  }
}
