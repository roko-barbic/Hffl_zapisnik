import 'package:json_annotation/json_annotation.dart';
import 'player_dto.dart';

part 'event.g.dart';

@JsonSerializable()
class Event {
  final int id;
  final PlayerDto playerOne;
  final PlayerDto playerTwo;
  final int type;
  final int teamGettingPoints;

  Event({
    required this.id,
    required this.playerOne,
    required this.playerTwo,
    required this.type,
    required this.teamGettingPoints,
  });

  factory Event.fromJson(Map<String, dynamic> json) =>
      _$EventFromJson(json);

  Map<String, dynamic> toJson() => _$EventToJson(this);
}