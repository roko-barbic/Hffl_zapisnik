
class Routes{
  static const String getClubsUrl = '/Club/getActiveClubs';
  static const String getTournamentUrl = '/Tournament';
  static const String deleteTournament = '/deleteTournament/';
  static const String createTournament = '/newTournament';
  static const String createTournamentWithPhoto = '/newTournamentWithPhoto';
  static const String generatePdf = '/Tournament/generatePdfReport?tournamentId=';
  static const String getGames = '/moreInfo/';
  static const String createGame = '/newGame/';
  static const String deleteGame = '/deleteGame/';
  static const String gameDetails = '/Game/detailedInfo/';
  static const String gameAndPlayerDetails = '/getPlayersNameForRegistration/';
  static const String registerPlayers = '/addJerseyNumbers';
  static const String createNewEvent = '/games/%s/createNewEvent';
  static const String deleteEvent = '/deleteEvent/';
  static const String login = '/api/Authentication/Login';
  static const String refreshTokenn = '/api/Authentication/RefreshToken';
  static const String clubPlayerStats = '/getClubStatsOfPlayers/';

}