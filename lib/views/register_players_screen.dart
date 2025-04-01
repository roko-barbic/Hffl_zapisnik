import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/register_players_swiper.dart';

class RegisterPlayersScreen extends StatefulWidget {
  const RegisterPlayersScreen({super.key});

  @override
  State<RegisterPlayersScreen> createState() => _RegisterPlayersScreenState();
}

class _RegisterPlayersScreenState extends State<RegisterPlayersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Registracija'),
        ),
        body: BlocBuilder<GameCubit, GameState>(builder: (context, state) {
          switch (state.gamesLoadingStatus) {
            case LoadingStatus.loading:
              return const CircularProgressIndicator();
            case LoadingStatus.success:
              if (state.selectedGameAndPlayers != null)
                return RegisterPlayersSwiper(
                  gameDetails: state.selectedGameAndPlayers!,
                );
              return const Text("Fail");
            case LoadingStatus.failure:
              return const Text("Fail");
            default:
              return const Text("Pocetno");
          }
        }));
  }
}
