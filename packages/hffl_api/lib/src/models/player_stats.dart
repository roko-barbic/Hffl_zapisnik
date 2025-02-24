import 'package:json_annotation/json_annotation.dart';

part 'player_stats.g.dart';

@JsonSerializable()
class PlayerStats {
  final String name;
  final String surname;
  final int touchdownCatchCounter;
  final int touchdownPassCounter;
  final int safteyCounter;
  final int interceptionCounter;
  final int extraPointCatchCounter;
  final int extreaPointPassCounter;

//<editor-fold desc="Data Methods">
  const PlayerStats({
    required this.name,
    required this.surname,
    required this.touchdownCatchCounter,
    required this.touchdownPassCounter,
    required this.safteyCounter,
    required this.interceptionCounter,
    required this.extraPointCatchCounter,
    required this.extreaPointPassCounter,
  });

  factory PlayerStats.fromJson(Map<String, dynamic> json) => _$PlayerStatsFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatsToJson(this);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PlayerStats &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          surname == other.surname &&
          touchdownCatchCounter == other.touchdownCatchCounter &&
          touchdownPassCounter == other.touchdownPassCounter &&
          safteyCounter == other.safteyCounter &&
          interceptionCounter == other.interceptionCounter &&
          extraPointCatchCounter == other.extraPointCatchCounter &&
          extreaPointPassCounter == other.extreaPointPassCounter);

  @override
  int get hashCode =>
      name.hashCode ^
      surname.hashCode ^
      touchdownCatchCounter.hashCode ^
      touchdownPassCounter.hashCode ^
      safteyCounter.hashCode ^
      interceptionCounter.hashCode ^
      extraPointCatchCounter.hashCode ^
      extreaPointPassCounter.hashCode;

  @override
  String toString() {
    return 'PlayerStats{' +
        ' name: $name,' +
        ' surname: $surname,' +
        ' touchdownCatchCounter: $touchdownCatchCounter,' +
        ' touchdownPassCounter: $touchdownPassCounter,' +
        ' safteyCounter: $safteyCounter,' +
        ' interceptionCounter: $interceptionCounter,' +
        ' extraPointCatchCounter: $extraPointCatchCounter,' +
        ' extreaPointPassCounter: $extreaPointPassCounter,' +
        '}';
  }

  PlayerStats copyWith({
    String? name,
    String? surname,
    int? touchdownCatchCounter,
    int? touchdownPassCounter,
    int? safteyCounter,
    int? interceptionCounter,
    int? extraPointCatchCounter,
    int? extreaPointPassCounter,
  }) {
    return PlayerStats(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      touchdownCatchCounter:
          touchdownCatchCounter ?? this.touchdownCatchCounter,
      touchdownPassCounter: touchdownPassCounter ?? this.touchdownPassCounter,
      safteyCounter: safteyCounter ?? this.safteyCounter,
      interceptionCounter: interceptionCounter ?? this.interceptionCounter,
      extraPointCatchCounter:
          extraPointCatchCounter ?? this.extraPointCatchCounter,
      extreaPointPassCounter:
          extreaPointPassCounter ?? this.extreaPointPassCounter,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': this.name,
      'surname': this.surname,
      'touchdownCatchCounter': this.touchdownCatchCounter,
      'touchdownPassCounter': this.touchdownPassCounter,
      'safteyCounter': this.safteyCounter,
      'interceptionCounter': this.interceptionCounter,
      'extraPointCatchCounter': this.extraPointCatchCounter,
      'extreaPointPassCounter': this.extreaPointPassCounter,
    };
  }

  factory PlayerStats.fromMap(Map<String, dynamic> map) {
    return PlayerStats(
      name: map['name'] as String,
      surname: map['surname'] as String,
      touchdownCatchCounter: map['touchdownCatchCounter'] as int,
      touchdownPassCounter: map['touchdownPassCounter'] as int,
      safteyCounter: map['safteyCounter'] as int,
      interceptionCounter: map['interceptionCounter'] as int,
      extraPointCatchCounter: map['extraPointCatchCounter'] as int,
      extreaPointPassCounter: map['extreaPointPassCounter'] as int,
    );
  }

//</editor-fold>
}