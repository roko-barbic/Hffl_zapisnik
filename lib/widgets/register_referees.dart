import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';


class PlayerSelectionScreen extends StatefulWidget {
  final List<PlayerDto> possibleReferees;
  final Function(List<int>) submitReferees;
  const PlayerSelectionScreen(
      {Key? key,
        required this.possibleReferees,
        required this.submitReferees
      }) : super(key: key);

  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  List<PlayerDto> _filteredPlayers = [];
  final List<PlayerDto> _selectedPlayers = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _filteredPlayers = List.from(widget.possibleReferees);
  }

  void _filterPlayers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredPlayers = List.from(widget.possibleReferees);
      } else {
        _filteredPlayers = widget.possibleReferees.where((player) {
          final fullName = '${player.firstName} ${player.LastName}'.toLowerCase();
          return fullName.contains(query.toLowerCase());
        }).toList();
      }
    });
  }

  void _selectPlayer(PlayerDto player) {
    if (_selectedPlayers.length < 4 && !_selectedPlayers.contains(player)) {
      setState(() {
        _selectedPlayers.add(player);
        _searchController.clear();
        _filterPlayers('');
      });
    } else if (_selectedPlayers.contains(player)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${player.firstName} je već odabran!')),
      );
    }
  }

  void _removeSelectedPlayer(PlayerDto player) {
    setState(() {
      _selectedPlayers.remove(player);
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool isMaxSelected = _selectedPlayers.length == 4;

    // Notice there is no Scaffold here anymore! Just the UI content.
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // 1. Display Selected Players (The "Chips")
          Wrap(
            spacing: 8.0,
            runSpacing: 4.0,
            children: _selectedPlayers.map((player) {
              return InputChip(
                label: Text('${player.firstName} ${player.LastName}'),
                onDeleted: () => _removeSelectedPlayer(player),
                deleteIcon: const Icon(Icons.cancel, size: 18),
              );
            }).toList(),
          ),

          const SizedBox(height: 16),

          // 2. Search Bar
          TextField(
            controller: _searchController,
            enabled: !isMaxSelected,
            decoration: InputDecoration(
              labelText: isMaxSelected ? 'Maksimalan broj sudaca odabran' : 'Pretraži suce...',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.search),
            ),
            onChanged: _filterPlayers,
          ),

          const SizedBox(height: 16),

          // 3. Search Results List
          Expanded(
            child: isMaxSelected
                ? const Center(
              child: Text(
                'Sva 4 suca su odabrana! Spremni za nastavak.',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            )
                : ListView.builder(
              itemCount: _filteredPlayers.length,
              itemBuilder: (context, index) {
                final player = _filteredPlayers[index];
                final isAlreadyPicked = _selectedPlayers.contains(player);

                return ListTile(
                  title: Text('${player.firstName} ${player.LastName}'),
                  trailing: isAlreadyPicked
                      ? const Icon(Icons.check_circle, color: Colors.green)
                      : const Icon(Icons.add),
                  enabled: !isAlreadyPicked,
                  onTap: () => _selectPlayer(player),
                );
              },
            ),
          ),

          // 4. Continue Button
          ElevatedButton(
            onPressed: isMaxSelected
                ? () {
              // Extract IDs to send to your backend!
              final selectedIds = _selectedPlayers.map((p) => p.id!).toList();

              // Call your Cubit to trigger the API request
              widget.submitReferees(selectedIds);

              print("Spreman za slanje ID-jeva: $selectedIds");
            }
                : null,
            child: const Text('Potvrdi suce'),
          )
        ],
      ),
    );
  }
}