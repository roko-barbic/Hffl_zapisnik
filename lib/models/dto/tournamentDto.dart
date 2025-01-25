//
//
//
// import 'dart:typed_data';
//
// import 'package:meta/meta.dart';
// import 'package:json_annotation/json_annotation.dart';
//
// part 'tournamentDto.g.dart';
//
//
// @immutable
// @JsonSerializable()
// class TournamentDto {
//
//   final DateTime date;
//   final String name;
//   final String? season;
//   final Uint8List? image;
//   final String? fileName;
//   final String? extension;
//
//   factory TournamentDto.fromJson(Map<String, dynamic> json) =>
//       _$TournamentDtoFromJson(json);
//
//   Map<String, dynamic> toJson() => _$TournamentDtoToJson(this);
//
// //<editor-fold desc="Data Methods">
//
//   const TournamentDto({
//     required this.date,
//     required this.name,
//     this.season,
//     this.image,
//     this.fileName,
//     this.extension,
//   });
//
// //<ed@override
//   bool operator ==(Object other) =>
//       identical(this, other) ||
//           (other is TournamentDto &&
//               runtimeType == other.runtimeType &&
//               date == other.date &&
//               name == other.name &&
//               season == other.season &&
//               image == other.image &&
//               fileName == other.fileName &&
//               extension == other.extension
//           );
//
//
//   @override
//   int get hashCode =>
//       date.hashCode ^
//       name.hashCode ^
//       season.hashCode ^
//       image.hashCode ^
//       fileName.hashCode ^
//       extension.hashCode;
//
//
//   @override
//   String toString() {
//     return 'TournamentDto{' +
//         ' date: $date,' +
//         ' name: $name,' +
//         ' season: $season,' +
//         ' image: $image,' +
//         ' fileName: $fileName,' +
//         ' extension: $extension,' +
//         '}';
//   }
//
//
//   TournamentDto copyWith({
//     DateTime? date,
//     String? name,
//     String? season,
//     Uint8List? image,
//     String? fileName,
//     String? extension,
//   }) {
//     return TournamentDto(
//       date: date ?? this.date,
//       name: name ?? this.name,
//       season: season ?? this.season,
//       image: image ?? this.image,
//       fileName: fileName ?? this.fileName,
//       extension: extension ?? this.extension,
//     );
//   }
//
//
//   Map<String, dynamic> toMap() {
//     return {
//       'date': this.date,
//       'name': this.name,
//       'season': this.season,
//       'image': this.image,
//       'fileName': this.fileName,
//       'extension': this.extension,
//     };
//   }
//
//   factory TournamentDto.fromMap(Map<String, dynamic> map) {
//     return TournamentDto(
//       date: map['date'] as DateTime,
//       name: map['name'] as String,
//       season: map['season'] as String,
//       image: map['image'] as Uint8List,
//       fileName: map['fileName'] as String,
//       extension: map['extension'] as String,
//     );
//   }
//
// }
