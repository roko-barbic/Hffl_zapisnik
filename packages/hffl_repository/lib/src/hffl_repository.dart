/// A repository that handles hffl related requests.
/// {@template hffl_repository}
/// {@endtemplate}
import 'dart:async';

import 'package:hffl_api/hffl_api.dart';

class HfflRepository {

  HfflRepository({HfflApi? hfflApiClient}) : _hfflApiClient = hfflApiClient ?? HfflApi();

  final HfflApi _hfflApiClient;

  Future<Clubs?> getClubs() async{
    final clubs = await _hfflApiClient.getClubs();
    return clubs;
  }

  Future<Tournaments?> getTournaments() async{
    final tournaments = await _hfflApiClient.getTournaments();
    return tournaments;
  }

  Future<bool?> deleteTournament(int tournamentId) async{
    return _hfflApiClient.deleteTournament(tournamentId);
  }


  Future<bool?> createTournament(Tournament tournament) async{
    return _hfflApiClient.createTournament(tournament);
  }

  //Widget initApp(){

  //realno repository ti treba ako ces sklapat neke komplekcsnije pozive sastavljene od vise poziva

}
