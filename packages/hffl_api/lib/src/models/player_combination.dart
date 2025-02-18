import 'package:json_annotation/json_annotation.dart';

part 'player_combination.g.dart';

@JsonSerializable()
class PlayerCombination {
  final String name;
  final String surname;
  final int? jerseyNumber;
  final int playerId;

//<editor-fold desc="Data Methods">
  const PlayerCombination({
    required this.name,
    required this.surname,
    this.jerseyNumber,
    required this.playerId,
  });

  factory PlayerCombination.fromJson(Map<String, dynamic> json) =>
      _$PlayerCombinationFromJson(json);

  Map<String, dynamic> toJson() => _$PlayerCombinationToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerCombination &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          surname == other.surname &&
          jerseyNumber == other.jerseyNumber &&
          playerId == other.playerId);

  @override
  int get hashCode =>
      name.hashCode ^
      surname.hashCode ^
      jerseyNumber.hashCode ^
      playerId.hashCode;

  @override
  String toString() {
    return 'PlayerCombination{' +
        ' name: $name,' +
        ' surname: $surname,' +
        ' jerseyNumber: $jerseyNumber,' +
        ' playerId: $playerId,' +
        '}';
  }

  PlayerCombination copyWith({
    String? name,
    String? surname,
    int? jerseyNumber,
    int? playerId,
  }) {
    return PlayerCombination(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      jerseyNumber: jerseyNumber ?? this.jerseyNumber,
      playerId: playerId ?? this.playerId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'surname': this.surname,
      'jerseyNumber': this.jerseyNumber,
      'playerId': this.playerId,
    };
  }

  factory PlayerCombination.fromMap(Map<String, dynamic> map) {
    return PlayerCombination(
      name: map['name'] as String,
      surname: map['surname'] as String,
      jerseyNumber: map['jerseyNumber'] as int,
      playerId: map['playerId'] as int,
    );
  }

//</editor-fold>
}