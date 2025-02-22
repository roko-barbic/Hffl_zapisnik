import 'dart:io';
import 'dart:typed_data';
import 'dart:convert';

import 'package:hffl_api/hffl_api.dart';
import 'package:dio/dio.dart';
import 'package:hffl_api/src/models/game_details.dart';
import 'package:hffl_api/src/models/game_dto_expanded.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';


import 'package:hffl_api/src/models/clubs.dart';
import 'package:hffl_api/src/routes/routes.dart';
import 'package:path_provider/path_provider.dart';

import 'models/tournaments.dart';

class HfflApi {

  final String conn;
  final Dio client;
  HfflApi({required this.conn, required this.client});

  //used to retrieve clubs stats
  Future<Clubs?> getClubs() async {
    final response = await client.get('$conn${Routes.getClubsUrl}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if (response.statusCode == 200) {
      dynamic data = response.data;
      var clubs = Clubs.fromJson(data as List<dynamic>);
      return clubs;
    }
    throw Exception();
    return null;
  }

  Future<Tournaments?> getTournaments() async {
    final response = await client.get('$conn${Routes.getTournamentUrl}',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if (response.statusCode == 200) {
      dynamic data = response.data;
      var torunaments = Tournaments.fromJson(data as List<dynamic>);
      return torunaments;
    }
    throw Exception();
  }

  Future<bool?> deleteTournament(int tournamentId) async {
    final response =
        await client.delete('$conn${Routes.deleteTournament}$tournamentId',
            options: Options(
              headers: {'Content-Type': 'application/json'},
            ));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception();
  }

  Future<bool?> createTournament(Tournament tournament) async {
    Map<String, dynamic> body = {
      "name": tournament.name,
      "date": tournament.date.toIso8601String(),
      "season": tournament.season
    };
    final response = await client.post('$conn${Routes.createTournament}',
        data: body,
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception();
  }

  Future<bool?> createTournamentWithPhoto({
    required String name,
    required DateTime date,
    required int season,
    required String coverPhoto,
  }) async {
    String? mimeType = lookupMimeType(coverPhoto) ?? 'application/octet-stream';
    final mimeSplit = mimeType.split('/');

    try {
      // Prepare multipart form data
      FormData formData = FormData.fromMap({
        "Name": name,
        "Date": date.toIso8601String(), // Convert DateTime to ISO8601 string
        "Season": season.toString(),
        "CoverPhoto": await MultipartFile.fromFile(
          coverPhoto,
          filename: "name",
          //todo prepravi ako moze biti i ime turnira sa razmakom
          contentType: MediaType.parse(
              mimeType), //MediaType(mimeSplit[0], mimeSplit[1]), // Adjust based on file type
        ),
      });

      // Send POST request
      Response response = await client.post(
        '$conn${Routes.createTournamentWithPhoto}',
        data: formData,
      );

      // Handle the response
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Exception: $e");
    }
  }

  Future<String?> fetchTournamentPhoto(int tournamentId) async {
    try {
      String url = 'http://your-api-url.com/tournament/$tournamentId/photo';

      Response response = await client.get(
        url,
        options: Options(
          responseType: ResponseType.bytes, // Expecting binary image data
        ),
      );

      if (response.statusCode == 200) {
        Uint8List imageBytes = Uint8List.fromList(response.data as List<int>);
        String base64String = base64Encode(imageBytes);
        return base64String;
      } else {
        print("Failed to fetch photo: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching photo: $e");
    }
  }

  Future<Tournaments?> fetchTournamentsWithPhoto() async {
    try {
      String url = '$conn/tournamentWithPhoto';

      Response response = await client.get(
        url,
      );

      if (response.statusCode == 200) {
        var torunaments = Tournaments.fromJson(response.data as List<dynamic>);
        return torunaments;
      } else {
        print("Failed to fetch photo: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching photo: $e");
    }
  }

  Future<String?> downloadPdf(int tournamentId, String fileName) async {
    try {
      final String url = '$conn${Routes.generatePdf}$tournamentId';
      //https://localhost:7011/Tournament/GeneratePdfReport?tournamentId=1'
      Directory directory = await getTemporaryDirectory();
      //String fileName = "Turnir-$tournamentId.pdf";
      String filePath = '${directory.path}/$fileName';
      Response response = await client.download(
        url,
        filePath,
        options: Options(
          responseType: ResponseType.bytes, // Expecting binary data
        ),
      );

      if (response.statusCode == 200) {
        return filePath;
      }
    } catch (e) {
      print('Error downloading PDF: $e');
    }
  }


  //games
  Future<Games?> fetchGames(int tournamentId) async{
    final String url = '$conn${Routes.getGames}$tournamentId';

    Response response = await client.get(
      url,
    );

    if(response.statusCode == 200){
      var games =  Games.fromJson(response.data as Map<String, dynamic>);
      return Games.fromJson(response.data as Map<String, dynamic>);
    }

    //return null;
  }

  Future<bool?> createGame(int tournamentId, int homeClubId, int awayClubId) async{
    try {
      final String url = '$conn${Routes.createGame}$tournamentId';
      final Map<String, dynamic> body = {
        "club_HomeId": homeClubId,
        "club_AwayId": awayClubId,
      };

      final response = await client.post(
        url,
        data: body,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error creating game: $e');
      return null;
    }
  }

  Future<bool> deleteGame(int gameId) async {

    final response =
    await client.delete('$conn${Routes.deleteGame}$gameId',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception();
  }

  Future<GameDto?> fethcGameDetails(int gameId) async {
    final String url = '$conn${Routes.gameDetails}$gameId';

    try {
      final response = await client.get(url);

      if (response.statusCode == 200) {

        final gameDto = GameDto.fromJson(response.data as Map<String, dynamic>);

        return gameDto;
      } else {
        print('Failed to fetch game details. Status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error fetching game details: $e');
      return null;
    }
  }

  Future<GameDetails?> fetchGameAndPlayerDetails(int gameId) async {
    try {
      final String url = '$conn${Routes.gameAndPlayerDetails}$gameId';
      final response = await client.get(url);

      if (response.statusCode == 200) {
        return GameDetails.fromJson(response.data as Map<String, dynamic>);
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching game details: $e');
      return null;
    }
  }

  Future<bool> addJerseyNumbersToPlayers(int gameId, Map<int, int?> homePlayers, Map<int, int?> awayPlayers) async {

    Map<String, int> homePlayersStringKeys =  Map.fromEntries(
        homePlayers.entries
            .where((entry) => entry.value != null)
            .map((entry) => MapEntry(entry.key.toString(), entry.value!))
    );
    Map<String, int> awayPlayersStringKeys =Map.fromEntries(
        awayPlayers.entries
            .where((entry) => entry.value != null)
            .map((entry) => MapEntry(entry.key.toString(), entry.value!))
    );

    final data = {
      'gameId': gameId,
      'homePlayersJerseyNumbers': homePlayersStringKeys,
      'awayPlayersJerseyNumbers': awayPlayersStringKeys,
    };
    final url = '$conn${Routes.registerPlayers}';

    try {
      final response = await client.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> createNewEvent(int gameId, EventDto eventDto) async {
    try {
      final String url = '$conn${Routes.createNewEvent}'.replaceAll("%s", gameId.toString());
      final response = await client.post(
        url,
        data: eventDto.toJson(),
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),);

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('Error fetching game details: $e');
      return false;
    }
  }

  Future<bool> deleteEvent(int eventId) async {

    final response =
    await client.delete('$conn${Routes.deleteEvent}$eventId',
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ));

    if (response.statusCode == 200) {
      return true;
    }
    throw Exception();
  }

}
