import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/cubit/tournament_cubit.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/upload_image.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class EnterTournament extends StatefulWidget {
  const EnterTournament({super.key});

  @override
  State<EnterTournament> createState() => _EnterTournamentState();
}

class _EnterTournamentState extends State<EnterTournament> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TournamentCubit, TournamentState>(
      builder: (context, state) {
        return switch (state.creatingTournament) {
          LoadingStatus.initial => const EnterTournamentValues(),
          LoadingStatus.loading =>
            const Center(child: CircularProgressIndicator()),
          LoadingStatus.failure => const TextWidget(
              text: "fail",
            ),
          LoadingStatus.success => const Center(
              child: TextWidget(
                text: "Uspjesno kreiran turnir",
              ),
            ),
        };
      },
    );
  }
}

class EnterTournamentValues extends StatefulWidget {
  const EnterTournamentValues({super.key});

  @override
  State<EnterTournamentValues> createState() => _EnterTournamentValuesState();
}

class _EnterTournamentValuesState extends State<EnterTournamentValues> {
  TextEditingController tournamentNameController = TextEditingController();
  DateTime selectedDate = DateTime.now();
  bool isSelectedTime = false;
  String? _path;

  void onUpdatePhoto(String path) {
    setState(() {
      _path = path;
    });
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: selectedDate,
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        isSelectedTime = true;
      });
    }
  }

  Tournament createTournamentObject() {
    return Tournament(
        date: selectedDate.add(const Duration(hours: 4)).toUtc(),
        name: tournamentNameController.text,
        season: DateTime.now().year.toString());
  }

  @override
  Widget build(BuildContext context) {
    //final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Align(
      alignment: Alignment.topCenter,
      child:
          // AnimatedContainer( //todo ovo sa pormjenom velicine je preseravanje jer ne ovsi o tome pa to mos makniot kad os ali mos i i ostavit da imas za primjer kako se to radi
          //     duration: const Duration(milliseconds: 300), // Smooth height transition
          //     curve: Curves.easeInOut,
          //     height: (MediaQuery.of(context).size.height * 0.3) +
          //         (keyboardHeight > 0 ? keyboardHeight : 0),
          //     child:
          SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: Column(children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: TextField(
              controller: tournamentNameController,
              decoration: const InputDecoration(
                labelText: 'Ime turnira:',
                hintText: 'Unesite ime turnira',
              ),
            ),
          ),
          const SizedBox(
            height: 45,
          ),
          ElevatedButton(
            onPressed: () => _selectDate(context),
            child: Text(
              isSelectedTime
                  ? DateFormat('dd/MM/yyyy')
                      .format(selectedDate.toLocal())
                      .toString()
                  : 'Odaberite datum',
            ),
          ),
          const SizedBox(
            height: 35,
          ),
          UploadPicture(
            onUpload: onUpdatePhoto,
          ),
          if (_path != null)
            FloatingActionButton(
              onPressed: () {
                // context
                //     .read<TournamentCubit>()
                //     .createTournament(createTournamentObject());
                context.read<TournamentCubit>().createTournament2(
                    tournamentNameController.text,
                    selectedDate.add(const Duration(hours: 4)).toUtc(),
                    2024,
                    _path ?? "");
                // Navigator.of(context).pop;
              },
              child: const Icon(Icons.add),
            )
        ]),
      ),
    );
  }
}

class TextWidget extends StatelessWidget {
  final String text;

  const TextWidget({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.4,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          SingleChildScrollView(
            child: SizedBox(
                width: MediaQuery.of(context).size.width * 1,
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(top: 28.0),
                  child: Text(
                    text,
                    style: const TextStyle(fontSize: 25),
                  ),
                ))),
          ),
        ],
      ),
    );
  }
}
