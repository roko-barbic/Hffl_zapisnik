import 'package:json_annotation/json_annotation.dart';

part 'player_stats.g.dart';

@JsonSerializable()
class PlayerStats {
  final String FirstName;
  final String LastName;
  final int? Id;
  final int TDPass;
  final int TDCatch;
  final int TDRun;
  final int IntPass;
  final int IntCatch;
  final int IntTD;
  final int XPPass;
  final int XPCatch;
  final int XPRun;
  final int Safety;

  factory PlayerStats.fromJson(Map<String, dynamic> json) => _$PlayerStatsFromJson(json);
  Map<String, dynamic> toJson() => _$PlayerStatsToJson(this);

//<editor-fold desc="Data Methods">

  const PlayerStats({
    required this.FirstName,
    required this.LastName,
    this.Id,
    required this.TDPass,
    required this.TDCatch,
    required this.TDRun,
    required this.IntPass,
    required this.IntCatch,
    required this.IntTD,
    required this.XPPass,
    required this.XPCatch,
    required this.XPRun,
    required this.Safety,
  });

//</e@override
  bool operator ==(Object other) =>
      identical(this, other) ||
          (other is PlayerStats &&
              runtimeType == other.runtimeType &&
              FirstName == other.FirstName &&
              LastName == other.LastName &&
              Id == other.Id &&
              TDPass == other.TDPass &&
              TDCatch == other.TDCatch &&
              TDRun == other.TDRun &&
              IntPass == other.IntPass &&
              IntCatch == other.IntCatch &&
              IntTD == other.IntTD &&
              XPPass == other.XPPass &&
              XPCatch == other.XPCatch &&
              XPRun == other.XPRun &&
              Safety == other.Safety
          );


  @override
  int get hashCode =>
      FirstName.hashCode ^
      LastName.hashCode ^
      Id.hashCode ^
      TDPass.hashCode ^
      TDCatch.hashCode ^
      TDRun.hashCode ^
      IntPass.hashCode ^
      IntCatch.hashCode ^
      IntTD.hashCode ^
      XPPass.hashCode ^
      XPCatch.hashCode ^
      XPRun.hashCode ^
      Safety.hashCode;


  @override
  String toString() {
    return 'PlayerStats{' +
        ' FirstName: $FirstName,' +
        ' LastName: $LastName,' +
        ' Id: $Id,' +
        ' TDPass: $TDPass,' +
        ' TDCatch: $TDCatch,' +
        ' TDRun: $TDRun,' +
        ' IntPass: $IntPass,' +
        ' IntCatch: $IntCatch,' +
        ' IntTD: $IntTD,' +
        ' XPPass: $XPPass,' +
        ' XPCatch: $XPCatch,' +
        ' XPRun: $XPRun,' +
        ' Safety: $Safety,' +
        '}';
  }


  PlayerStats copyWith({
    String? FirstName,
    String? LastName,
    int? Id,
    int? TDPass,
    int? TDCatch,
    int? TDRun,
    int? IntPass,
    int? IntCatch,
    int? IntTD,
    int? XPPass,
    int? XPCatch,
    int? XPRun,
    int? Safety,
  }) {
    return PlayerStats(
      FirstName: FirstName ?? this.FirstName,
      LastName: LastName ?? this.LastName,
      Id: Id ?? this.Id,
      TDPass: TDPass ?? this.TDPass,
      TDCatch: TDCatch ?? this.TDCatch,
      TDRun: TDRun ?? this.TDRun,
      IntPass: IntPass ?? this.IntPass,
      IntCatch: IntCatch ?? this.IntCatch,
      IntTD: IntTD ?? this.IntTD,
      XPPass: XPPass ?? this.XPPass,
      XPCatch: XPCatch ?? this.XPCatch,
      XPRun: XPRun ?? this.XPRun,
      Safety: Safety ?? this.Safety,
    );
  }


  Map<String, dynamic> toMap() {
    return {
      'FirstName': this.FirstName,
      'LastName': this.LastName,
      'Id': this.Id,
      'TDPass': this.TDPass,
      'TDCatch': this.TDCatch,
      'TDRun': this.TDRun,
      'IntPass': this.IntPass,
      'IntCatch': this.IntCatch,
      'IntTD': this.IntTD,
      'XPPass': this.XPPass,
      'XPCatch': this.XPCatch,
      'XPRun': this.XPRun,
      'Safety': this.Safety,
    };
  }

  factory PlayerStats.fromMap(Map<String, dynamic> map) {
    return PlayerStats(
      FirstName: map['FirstName'] as String,
      LastName: map['LastName'] as String,
      Id: map['Id'] as int,
      TDPass: map['TDPass'] as int,
      TDCatch: map['TDCatch'] as int,
      TDRun: map['TDRun'] as int,
      IntPass: map['IntPass'] as int,
      IntCatch: map['IntCatch'] as int,
      IntTD: map['IntTD'] as int,
      XPPass: map['XPPass'] as int,
      XPCatch: map['XPCatch'] as int,
      XPRun: map['XPRun'] as int,
      Safety: map['Safety'] as int,
    );
  }

}