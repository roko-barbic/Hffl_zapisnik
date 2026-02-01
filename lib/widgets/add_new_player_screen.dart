import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/clubs_cubit.dart';

class AddPlayer extends StatefulWidget {
  final List<PlayerDto> archivedPlayer;
  final Function(CreatePlayerDto) createPlayer;
  final Function(ArchivePlayerDto) returnArchivedPlayer;
  final int clubId;

  const AddPlayer(
      {required this.archivedPlayer,
      required this.createPlayer,
      required this.clubId,
      required this.returnArchivedPlayer,
      super.key});

  @override
  State<AddPlayer> createState() => _AddPlayerState();
}

class _AddPlayerState extends State<AddPlayer> {
  bool? isArchived;
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  DateTime? _dateOfBirth;
  int? selectedArchivedPlayer;

  @override
  void initState() {
    isArchived = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ClubsCubit, ClubsState>(builder: (context, state) {
      return Scaffold(
          appBar: AppBar(
            title: const Text("Registracija"),
          ),
          body: Column(
            children: <Widget>[
              checkForArchivedPlayerWidget(),
              const SizedBox(height: 20),
              (isArchived ?? false)
                  ? archivedPlayerList(widget.archivedPlayer)
                  : newPlayerInput(),
              if (isProceedAvailable())
                ElevatedButton(
                  onPressed: () => onProceed(),
                  child: const Text("Spremi igrača"),
                ),
            ],
          ));
    });
  }

  Widget checkForArchivedPlayerWidget() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
            bottom: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 4),
            left: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 1),
            right: BorderSide(
                color: Theme.of(context).colorScheme.primary, width: 1)),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(42), bottomRight: Radius.circular(42)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "Postoji li igrač u arhivi?",
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w400),
              ),
            ),
            SizedBox(
              width: 100,
              height: 40,
              child: SegmentedButton(
                showSelectedIcon: false,
                style: ButtonStyle(
                  visualDensity: VisualDensity.compact,
                  backgroundColor: MaterialStateProperty.resolveWith((states) {
                    if (states.contains(MaterialState.selected)) {
                      return (isArchived == true)
                          ? Theme.of(context).primaryColor.withOpacity(0.8)
                          : Colors.red.withOpacity(0.8);
                    }
                    return Colors.grey.shade300;
                  }),
                ),
                segments: const <ButtonSegment<bool>>[
                  ButtonSegment<bool>(value: true, label: Icon(Icons.check)),
                  ButtonSegment<bool>(value: false, label: Icon(Icons.remove))
                ],
                selected: <bool>{isArchived!},
                onSelectionChanged: (newSet) {
                  setState(() {
                    isArchived = newSet.first;
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget archivedPlayerList(List<PlayerDto> players) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Text("Odaberi igrača kojega vračaš u aktivni roster:"),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(10),
                itemCount: players.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 1,
                  mainAxisSpacing: 3,
                  mainAxisExtent: 60,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {},
                  child: archivedPlayerRow(players[index]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget archivedPlayerRow(PlayerDto player) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(player.id.toString()),
            Text(player.firstName),
            Text(player.LastName),
            Checkbox(
                value: selectedArchivedPlayer == player.id,
                onChanged: (isSelected) {
                  setState(() {
                    if (isSelected ?? false)
                      selectedArchivedPlayer = player.id;
                    else
                      selectedArchivedPlayer = null;
                  });
                })
          ],
        ),
        Divider(
          height: 2,
          thickness: 3,
          color: Theme.of(context).primaryColor,
        )
      ],
    );
  }

  Widget newPlayerInput() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          TextField(
            controller: _firstNameController,
            decoration: const InputDecoration(
              labelText: 'Ime',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lastNameController,
            decoration: const InputDecoration(
              labelText: 'Prezime',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _pickDate,
            child: AbsorbPointer(
              child: TextField(
                decoration: InputDecoration(
                  //labelText: 'Datum rođenja',
                  border: const OutlineInputBorder(),
                  suffixIcon: const Icon(Icons.calendar_today),
                  hintText: _dateOfBirth == null
                      ? 'Odaberi datum'
                      : "${_dateOfBirth!.day}.${_dateOfBirth!.month}.${_dateOfBirth!.year}.",
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dateOfBirth ?? DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1950),
      lastDate: now,
    );
    if (picked != null) {
      setState(() {
        _dateOfBirth = picked;
      });
    }
  }

  bool isProceedAvailable() {
    if (isArchived ?? false) {
      return selectedArchivedPlayer != null;
    }
    if (_firstNameController.text != "" &&
        _lastNameController.text != "" &&
        _dateOfBirth != null) {
      return true;
    }
    return false;
  }

  void onProceed() {
    if (isArchived ?? false) {
      widget.returnArchivedPlayer(ArchivePlayerDto(
          playerId: selectedArchivedPlayer!, clubId: widget.clubId));
    }
    widget.createPlayer(CreatePlayerDto(
        firstName: _firstNameController.text,
        lastname: _lastNameController.text,
        dateOfBirth: _dateOfBirth!,
        clubId: widget.clubId));
  }
}
