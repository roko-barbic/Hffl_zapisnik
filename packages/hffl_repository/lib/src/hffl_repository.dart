/// A repository that handles hffl related requests.
/// {@template hffl_repository}
/// {@endtemplate}
import 'dart:async';
import 'package:dio/dio.dart';

import 'package:hffl_api/hffl_api.dart';

class HfflRepository {
  HfflRepository({HfflApi? hfflApiClient})
      : _hfflApiClient = hfflApiClient ?? HfflApi(conn: "aaaa", client: new Dio());

  final HfflApi _hfflApiClient;

  Future<Clubs?> getClubs() async {
    final clubs = await _hfflApiClient.getClubs();
    return clubs;
  }

  Future<Tournaments?> getTournaments() async {
    final tournaments = await _hfflApiClient.getTournaments();
    return tournaments;
  }

  Future<bool?> deleteTournament(int tournamentId) async {
    return _hfflApiClient.deleteTournament(tournamentId);
  }

  Future<bool?> createTournament(Tournament tournament) async {
    return _hfflApiClient.createTournament(tournament);
  }

  Future<bool?> createTournamentWithPhoto(String name, DateTime date,
      int season, String coverPhoto) async {
    return _hfflApiClient.createTournamentWithPhoto(
        name: name,
        date: date,
        season: season,
        coverPhoto: coverPhoto,
        );
  }

  Future<Tournaments?> fetchTournaments(){
    return _hfflApiClient.fetchTournamentsWithPhoto();
  }

  Future<String?> downloadTournamentPdf(int tournamentId, String fileName){
    return _hfflApiClient.downloadPdf(tournamentId, fileName);
  }

  Future<Games?> fetchGames(int tournamentId){
    return _hfflApiClient.fetchGames(tournamentId);
  }

  Future<bool?> createGame(int tournamentId, int homeClubId, int awayClubId){
    return _hfflApiClient.createGame(tournamentId, homeClubId, awayClubId);
  }

  Future<bool> deleteGame(int gameId){
    return _hfflApiClient.deleteGame(gameId);
  }

  Future<GameDto?> getGameDetails(int gameId){
    return _hfflApiClient.fethcGameDetails(gameId);
  }

  Future<GameDetails?> getGameAndPlayerDetails(int gameId){
    return _hfflApiClient.fetchGameAndPlayerDetails(gameId);
  }

  Future<bool> addJerseyNumbersToPlayers(int gameId, Map<int, int?> homePlayers, Map<int, int?> awayPlayers){
    return _hfflApiClient.addJerseyNumbersToPlayers(gameId, homePlayers, awayPlayers);
  }

  Future<bool> addNewEvent(int gameId, EventDto eventDto){
    return _hfflApiClient.createNewEvent(gameId, eventDto);
  }

  Future<bool> deleteEvent(int eventId){
    return _hfflApiClient.deleteEvent(eventId);
  }

//Widget initApp(){

//realno repository ti treba ako ces sklapat neke komplekcsnije pozive sastavljene od vise poziva
}
