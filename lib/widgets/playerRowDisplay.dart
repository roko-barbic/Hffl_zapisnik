import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class PlayerStatsDataSource extends DataGridSource {
  PlayerStatsDataSource({required List<PlayerStats> players}) {
    _playerData = players.map<DataGridRow>((player) => DataGridRow(cells: [
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
    ])).toList();
  }

  List<DataGridRow> _playerData = [];

  @override
  List<DataGridRow> get rows => _playerData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((cell) {
        return Container(
          alignment: cell.columnName == 'Name' ? Alignment.centerLeft : Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            cell.value.toString(),
            overflow: TextOverflow.ellipsis,
          ),
        );
      }).toList(),
    );
  }
}