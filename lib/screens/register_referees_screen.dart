import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_zapisnik/cubit/game_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/centered_svg.dart';
import 'package:hffl_zapisnik/widgets/register_referees.dart';

class RegisterRefereesScreen extends StatelessWidget {
  const RegisterRefereesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registracija sudaca'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<GameCubit, GameState>(
        builder: (context, state) {
          switch (state.selectedGameLoadingStatus) {
            case LoadingStatus.loading:
              return const Center(child: CircularProgressIndicator());

            case LoadingStatus.success:
              final referees = state.possibleReferees ?? [];
              if (referees.isEmpty) {
                return const Center(child: Text("Nema dostupnih sudaca."));
              }
              return PlayerSelectionScreen(
                  possibleReferees: referees,
                  submitReferees: (List<int> refereeIds)=> context.read<GameCubit>().submitReferees(refereeIds, context)
              );

            case LoadingStatus.failure:
              return const Center(child: Text("Greška pri učitavanju sudaca."));

            default:
              return const CenteredSvg();
          }
        },
      ),
    );
  }
}
