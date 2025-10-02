import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:hffl_zapisnik/enums/clubs_status_enum.dart';
import 'package:hffl_zapisnik/widgets/modals/pdf_view_popup.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:hffl_repository/hffl_repository.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:hffl_zapisnik/global_keys.dart';
import 'package:loader_overlay/loader_overlay.dart';

part 'tournament_state.dart';

part 'tournament_cubit.g.dart';

class TournamentCubit extends Cubit<TournamentState> {
  TournamentCubit(this._hfflRepository)
      : super(const TournamentState(
            tournamentLoadingStatus: LoadingStatus.initial,
            creatingTournament: LoadingStatus.initial,
            deletingTournament: LoadingStatus.initial));

  final HfflRepository _hfflRepository;

  Future<void> fetchTournaments(int season) async {
    try {
      emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.loading));
      final tournaments = await _hfflRepository.fetchTournaments(season); //ovo sam changeo
      if(tournaments != null)
        emit(state.copyWith(
          tournaments: tournaments,
          tournamentLoadingStatus: LoadingStatus.success));
    } on Exception {
      emit(state.copyWith(tournamentLoadingStatus: LoadingStatus.failure));
    }
  }

  Future<void> createTournament(Tournament tournament) async {
    try {
      emit(state.copyWith(creatingTournament: LoadingStatus.loading));
      final creation = await _hfflRepository.createTournament(tournament);
      if (creation == true) {
        emit(state.copyWith(creatingTournament: LoadingStatus.success));
      }
    } on Exception {
      emit(state.copyWith(creatingTournament: LoadingStatus.failure));
    }
  }

  Future<void> createTournament2(String name, DateTime date, int season,
      String coverPhoto) async {
    navigatorKey.currentContext?.loaderOverlay.show();
    try {
      emit(state.copyWith(creatingTournament: LoadingStatus.loading));
      final creation = await _hfflRepository.createTournamentWithPhoto(
          name, date, season, coverPhoto);
      if (creation == true) {
        await fetchTournaments(season);
        emit(state.copyWith(creatingTournament: LoadingStatus.success));
      }
    } on Exception {
      emit(state.copyWith(creatingTournament: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }

  Future<void> deleteTournament(int tournamentId, int season) async {
    navigatorKey.currentContext?.loaderOverlay.show();
    try {
      emit(state.copyWith(deletingTournament: LoadingStatus.loading));
      final deletion = await _hfflRepository.deleteTournament(tournamentId);
      if (deletion == true) {
        emit(state.copyWith(deletingTournament: LoadingStatus.success));
        await fetchTournaments(season);
      }
    } on Exception {
      emit(state.copyWith(deletingTournament: LoadingStatus.failure));
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }

  void resetCreatingTournament() {
    emit(state.copyWith(creatingTournament: LoadingStatus.initial));
  }

  Future<void> dowloadTournamentSummary(int tournamentId, BuildContext context) async{
    navigatorKey.currentContext?.loaderOverlay.show();
    String fileName = "Turnir-$tournamentId.pdf";
    String? filePath = await _hfflRepository.downloadTournamentPdf(tournamentId, fileName);

    if (filePath != null) {
      _showPdfPopup(context, filePath, fileName);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to download the PDF')),
      );
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }

  void _showPdfPopup(BuildContext context, String filePath, String fileName) {
    showDialog(
      context: context,
      builder: (context) => PdfPopupWidget(pdfFilePath: filePath, pdfFileName: fileName),
    );
  }

  Future<void> toggleTournamentStatus(bool isFinished, int tournamentId, int season)async{

    navigatorKey.currentContext?.loaderOverlay.show();
    bool isSuccesful;
    if(isFinished){
      isSuccesful = await _hfflRepository.startAgainTournament(tournamentId);
    }else{
      isSuccesful = await _hfflRepository.finishTorunament(tournamentId);
    }
    if(isSuccesful){
      await fetchTournaments(season);
    }
    navigatorKey.currentContext?.loaderOverlay.hide();
  }


  @override
  TournamentState fromJson(Map<String, dynamic> json) =>
      TournamentState.fromJson(json);

  @override
  Map<String, dynamic> toJson(TournamentState state) => state.toJson();
}
