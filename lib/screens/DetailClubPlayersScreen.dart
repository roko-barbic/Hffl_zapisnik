import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_zapisnik/classes/club.dart';
import 'package:hffl_zapisnik/classes/player.dart';
import 'package:hffl_zapisnik/widgets/playerRowDisplay.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailClubPlayersScreen extends StatefulWidget {
  Club club;
  DetailClubPlayersScreen({required this.club, super.key});

  @override
  State<DetailClubPlayersScreen> createState() =>
      _DetailClubPlayersScreenState();
}

class _DetailClubPlayersScreenState extends State<DetailClubPlayersScreen> {
  List<Player> players = [];
  bool isLoaded = false;

  Future<void> getPlayers() async {
    print('get players');
    var url = Uri.https(
        'hfflzapisnik.azurewebsites.net', '/Club/' + widget.club.id.toString());
    final response = await http.get(url);
    final dynamic listData = json.decode(response.body);
    final List<Player> _loadedPlayers = [];
    for (var item in listData['players']) {
      _loadedPlayers.add(Player(
          name: item['firstName'],
          surname: item['lastName'],
          touchdownCatchCounter: item['tdCatch'],
          interceptionCounter: item['intCatch'],
          safteyCounter: item['safety'],
          touchdownPassCounter: item['tdPass'],
          extraPointCatchCounter: item['xpCatch'],
          extreaPointPassCounter: item['xpPass']));
    }
    print(_loadedPlayers);
    players.clear();
    setState(() {
      players.addAll(_loadedPlayers);
      isLoaded = true;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (players == null) {
      getPlayers().then((_) => {isLoaded = true});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPlayers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
        widget.club.name,
      )),
      body: !isLoaded
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Align(
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.94,
                    height: 50,
                    child: Card(
                      elevation: 2,
                      shape: const RoundedRectangleBorder(
                        side: BorderSide(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Row(children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.07,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.20,
                          child: const Text(
                            "#Igrač",
                          ),
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: const Text("TDP")),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: const Text("TDC")),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: const Text("INT")),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: const Text("XPP")),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.05,
                        ),
                        SizedBox(
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: const Text("XPC")),
                      ]),
                    ),
                  ),
                ),
                Expanded(
                  child: GridView.builder(
                      itemCount: players.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 3,
                        mainAxisExtent: 50,
                      ),
                      itemBuilder: (context, index) =>
                          PlayerRowDisplay(player: players[index])),
                ),
              ],
            ),
    );
  }
}
