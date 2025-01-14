/// {@template hffl_api}
/// The interface and models for an API providing access to hffl.
/// {@endtemplate}
///
import 'package:hffl_api/hffl_api.dart';
import 'package:dio/dio.dart';

import 'package:hffl_api/src/models/clubs.dart';
import 'package:hffl_api/src/routes/routes.dart';

import 'models/tournaments.dart';

class HfflApi {

  const HfflApi();
  final String conn = "https://c151-93-142-66-172.ngrok-free.app";

  //used to retrieve clubs stats
  Future<Clubs?> getClubs() async {
    Dio client = new Dio();
    final response = await client.get(
        '$conn${Routes.getClubsUrl}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if(response.statusCode == 200){
      dynamic data = response.data;
      var clubs = Clubs.fromJson(data as List<dynamic>);
      return clubs;
    }
    throw Exception();
    return null;
  }

  Future<Tournaments?> getTournaments() async{
    Dio client = new Dio();
    final response = await client.get(
        '$conn${Routes.getTournamentUrl}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if(response.statusCode == 200){
      dynamic data = response.data;
      var torunaments = Tournaments.fromJson(data as List<dynamic>);
      return torunaments;
    }
    throw Exception();
  }

  Future<bool?> deleteTournament(int tournamentId) async{
    Dio client = new Dio();

    final response = await client.delete(
        '$conn${Routes.deleteTournament}$tournamentId',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if(response.statusCode == 200){

      return true;
    }
    throw Exception();
  }


  Future<bool?> createTournament(Tournament tournament) async{
    Dio client = new Dio();

    final response = await client.post(
        '$conn${Routes.createTournament}',
        queryParameters: tournament.toJson(),
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if(response.statusCode == 200){

      return true;
    }
    throw Exception();
  }

  //used to retrieve tournament info
  //Future<void> getTournamentsInfo();

  //used to retrieve tournament general info about games
  //Future<void> getGames();

  //used to delete game
  //Future<void> deleteGame();




}
