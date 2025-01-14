import 'package:hffl_api/hffl_api.dart';
import 'package:dio/dio.dart';
import 'package:hffl_api/src/models/clubs.dart';
import 'package:hffl_api/src/models/tournaments.dart';
import 'package:hffl_api/src/routes/routes.dart';

class TournamentActions {

  Future<Clubs?> getClubs() async {
    Dio client = new Dio();
    final response = await client.get(
      'https://f97e-93-142-163-172.ngrok-free.app${Routes.getClubsUrl}',
      options: Options(
      headers: {'Content-Type': 'application/json'},
    ));

    //stao si na djelu di pozivas funkciju i onda nastavi s arhitekturom blocak

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
        'https://f97e-93-142-163-172.ngrok-free.app${Routes.getTournamentUrl}',
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


}
