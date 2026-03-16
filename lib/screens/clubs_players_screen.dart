import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import 'package:hffl_zapisnik/widgets/player_row_display.dart';

class ClubsPlayersScreen extends StatefulWidget {
  final Function(int) archivePlayer;
  final Function() createNewPlayer;
  final String clubName;
  final List<PlayerStats> players;
  final int season;
  final bool isGuestMode;

  const ClubsPlayersScreen(
      {required this.archivePlayer,
      required this.createNewPlayer,
      required this.players,
      required this.clubName,
      required this.season,
      required this.isGuestMode,
      super.key});

  @override
  State<ClubsPlayersScreen> createState() => _ClubsPlayersScreenState();
}

class _ClubsPlayersScreenState extends State<ClubsPlayersScreen> {
  late PlayerStatsDataSource _dataSource;

  @override
  void initState() {
    super.initState();
    _dataSource = PlayerStatsDataSource(
        players: widget.players, archivePlayer: widget.archivePlayer);
  }

  @override
  void didUpdateWidget(ClubsPlayersScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.players != widget.players) {
      _dataSource = PlayerStatsDataSource(
          players: widget.players, archivePlayer: widget.archivePlayer);
      _dataSource.notifyListeners();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.clubName),
            if(widget.season == DateTime.now().year && !widget.isGuestMode)
              IconButton(
                onPressed: () => widget.createNewPlayer(),
                icon: const Icon(Icons.add))
          ],
        ),
      ),
      body: widget.players.isEmpty
          ? const Center(
              child:
                  Text("No players available", style: TextStyle(fontSize: 16)))
          : SfDataGrid(
              source: _dataSource,
              allowSorting: true,
              columnWidthMode: ColumnWidthMode.auto,
              frozenColumnsCount: 1,
              columns: [
                GridColumn(
                  columnName: 'Name',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.centerLeft,
                    child:
                        const Text('Player', overflow: TextOverflow.ellipsis),
                  ),
                  width: 120, // Wider for names
                ),
                GridColumn(
                  columnName: 'TDP',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('TD/P', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'TDC',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('TD/C', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'TDR',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('TD/R', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'IntP',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('INT/P', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'IntC',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('INT/C', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'IntTD',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child:
                        const Text('INT/TD', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'XPP',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('XP/P', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'XPC',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('XP/C', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'XPR',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('XP/R', overflow: TextOverflow.ellipsis),
                  ),
                ),
                GridColumn(
                  columnName: 'SAF',
                  label: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    alignment: Alignment.center,
                    child: const Text('SAF', overflow: TextOverflow.ellipsis),
                  ),
                ),
              ],
            ),
    );
  }
}