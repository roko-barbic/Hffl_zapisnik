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
    2: const Color.fromRGBO(118, 143, 234, 1), //Split
    1: const Color.fromRGBO(209, 141, 56, 1), //Zagreb
    3: const Color.fromRGBO(0, 132, 184, 1), //Osijek
    5: const Color.fromRGBO(54, 70, 121, 1), // Dubrovnik
    4: const Color.fromRGBO(206, 65, 71, 1), // Banja Luka
    6: const Color.fromRGBO(0, 0, 0, 1), //Tuzla
  };
}

class ClubIconsPng{
  static final Map<int, String> clubIcon = {
    2: "assets/images/club_image_split_png.png", //Split
    1: "assets/images/club_image_zagreb_png.png", //Zagreb
    3: "assets/images/club_image_osijek_png.png", //Osijek
    5: "assets/images/club_image_dubrovnik_png.png", // Dubrovnik
    6: "assets/images/club_image_sarajevo_mozd_png.png", //Tuzla
    4: "assets/images/club_image_banja_luka_png.png",// Banja Luka
  };
}

