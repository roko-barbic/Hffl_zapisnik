import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';
import 'package:hffl_zapisnik/widgets/add_new_player_screen.dart';

class AddNewPlayerContainer extends StatefulWidget {
  const AddNewPlayerContainer({super.key});

  @override
  State<AddNewPlayerContainer> createState() => _AddNewPlayerContainerState();
}

class _AddNewPlayerContainerState extends State<AddNewPlayerContainer> {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubsCubit, ClubsState>(
      builder: (context, state){
        Vm_AddPlayer vm = Vm_AddPlayer.fromState(state);
        return AddPlayer(
          archivedPlayer: vm.archivedPlayer,
          clubId: vm.clubId,
          createPlayer: createPlayer,
          returnArchivedPlayer: returnArchivedPlayer,
        );
      },
    );
  }

  void createPlayer(CreatePlayerDto createPlayerDto){
    context.read<ClubsCubit>().creatNewPlayer(createPlayerDto);
  }

  void returnArchivedPlayer(ArchivePlayerDto archivedPlayerId){
    context.read<ClubsCubit>().returnArchivedPlayer(archivedPlayerId);
  }

}

class Vm_AddPlayer{

  final List<PlayerDto> archivedPlayer;
  final int clubId;

  Vm_AddPlayer.fromState(ClubsState state)
      : archivedPlayer = state.archivedPlayer ?? [],
        clubId = state.clubPlayersStats?.clubId ?? 0;

//<editor-fold desc="Data Methods">


  const Vm_AddPlayer({
    required this.archivedPlayer,
    required this.clubId,
  });


  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is Vm_AddPlayer &&
              runtimeType == other.runtimeType &&
              archivedPlayer == other.archivedPlayer &&
              clubId == other.clubId
          );


  @override
  int get hashCode =>
      archivedPlayer.hashCode ^
      clubId.hashCode;


  @override
  String toString() {
    return 'Vm_AddPlayer{' +
        ' archivedPlayer: $archivedPlayer,' +
        ' clubId: $clubId,' +
        '}';
  }


  Vm_AddPlayer copyWith({
    List<PlayerDto>? archivedPlayer,
    int? clubId,
  }) {
    return Vm_AddPlayer(
      archivedPlayer: archivedPlayer ?? this.archivedPlayer,
      clubId: clubId ?? this.clubId,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'archivedPlayer': this.archivedPlayer,
      'clubId': this.clubId,
    };
  }

  factory Vm_AddPlayer.fromMap(Map<String, dynamic> map) {
    return Vm_AddPlayer(
      archivedPlayer: map['archivedPlayer'] as List<PlayerDto>,
      clubId: map['clubId'] as int,
    );
  }


//</editor-fold>
}