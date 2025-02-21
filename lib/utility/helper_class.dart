import 'package:flutter/material.dart';

class Helper{
  Color getClubColor(int? clubId){
    return ClubColors.clubColors[clubId] ?? Colors.grey;
  }

  List<Color> getListOfColorsToBlend(int homeClubId, int awayClubId){
    return [
      getClubColor(homeClubId),
      Color.lerp(
          getClubColor(homeClubId),
          getClubColor(awayClubId),
          0.5 // Blend factor (0.0 = first color, 1.0 = second color, 0.5 = even blend)
      )!,
      getClubColor(awayClubId),
    ];
  }
}


class ClubColors {
  static final Map<int, Color> clubColors = {
    1: const Color.fromRGBO(91, 128, 51, 1), //Bjelovar
    2: const Color.fromRGBO(150, 170, 239, 1), //Split
    3: const Color.fromRGBO(209, 141, 56, 1), //Zagreb
    4: const Color.fromRGBO(40, 40, 40, 1), //Osijek
    6: const Color.fromRGBO(54, 70, 121, 1), // Dubrovnik
    8: const Color.fromRGBO(206, 65, 71, 1), // Banja Luka
  };
}

class ClubIconsPng{
  static final Map<int, String> clubIcon = {
    1: "assets/images/club_image_id_1.png", //Bjelovar //todo dodat sliku
    2: "assets/images/club_image_id_1.png", //Split
    3: "assets/images/club_image_zagreb_png.png", //Zagreb
    4: "assets/images/club_image_osijek_png.png", //Osijek
    6: "assets/images/club_image_dubrovnik_png.png", // Dubrovnik
    7: "assets/images/club_image_sarajevo_mozd_png.png", //sarajevo mozda
    8: "assets/images/club_image_banja_luka_png.png",// Banja Luka
  };
}

