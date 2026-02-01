import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/global_keys.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayerStatsDataSource extends DataGridSource {

  List<DataGridRowCustom>? _playerDataCustom;
  final Function(int playerId) archivePlayer;

  PlayerStatsDataSource({required List<PlayerStats> players, required this.archivePlayer}) {
    _playerDataCustom = players.map<DataGridRowCustom>((player) {
      return  DataGridRowCustom(playerId: player.Id ?? 0, playerData: DataGridRow(cells: [
        DataGridCell<String>(
          columnName: 'Name',
          value: "${player.LastName} ${player.FirstName.characters.first}.",
        ),
        DataGridCell<int>(columnName: 'TDP', value: player.TDPass),
        DataGridCell<int>(columnName: 'TDC', value: player.TDCatch),
        DataGridCell<int>(columnName: 'TDR', value: player.TDRun),
        DataGridCell<int>(columnName: 'IntP', value: player.IntPass),
        DataGridCell<int>(columnName: 'IntC', value: player.IntCatch),
        DataGridCell<int>(columnName: 'IntTD', value: player.IntTD),
        DataGridCell<int>(columnName: 'XPP', value: player.XPPass),
        DataGridCell<int>(columnName: 'XPC', value: player.XPCatch),
        DataGridCell<int>(columnName: 'XPR', value: player.XPRun),
        DataGridCell<int>(columnName: 'SAF', value: player.Safety),
      ]));
    }).toList();

  }

  @override
  List<DataGridRow> get rows => _playerDataCustom!.map<DataGridRow>((DataGridRowCustom row){
    return row.playerData;
  }).toList();

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    final customRow = _playerDataCustom!.firstWhere(
          (element) => element.playerData == row,
    );

    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return GestureDetector(
          onLongPress: (){
            archivePlayer(customRow.playerId);
          },
          child: Container(
            alignment: cell.columnName == 'Name' ? Alignment.centerLeft : Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(
              cell.value.toString(),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        );
      }).toList(),
    );
  }

}

class DataGridRowCustom{
  final DataGridRow playerData;
  final int playerId;

//<editor-fold desc="Data Methods">
  const DataGridRowCustom({
    required this.playerData,
    required this.playerId,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DataGridRowCustom &&
          runtimeType == other.runtimeType &&
          playerData == other.playerData &&
          playerId == other.playerId);

  @override
  int get hashCode => playerData.hashCode ^ playerId.hashCode;

  @override
  String toString() {
    return 'DataGridRowCustom{' +
        ' playerData: $playerData,' +
        ' playerId: $playerId,' +
        '}';
  }

  DataGridRowCustom copyWith({
    DataGridRow? playerData,
    int? playerId,
  }) {
    return DataGridRowCustom(
      playerData: playerData ?? this.playerData,
      playerId: playerId ?? this.playerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'playerData': this.playerData,
      'playerId': this.playerId,
    };
  }

  factory DataGridRowCustom.fromMap(Map<String, dynamic> map) {
    return DataGridRowCustom(
      playerData: map['playerData'] as DataGridRow,
      playerId: map['playerId'] as int,
    );
  }

//</editor-fold>
}