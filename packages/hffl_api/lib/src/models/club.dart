import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:hffl_api/hffl_api.dart';
import 'package:uuid/uuid.dart';

part 'club.g.dart';

@immutable
@JsonSerializable()
class Club {

  final int id;
  final String name;
  final int win;
  final int draw;
  final int loss;

  factory Club.fromJson(Map<String, dynamic> json) => _$ClubFromJson(json);
  Map<String, dynamic> toJson() => _$ClubToJson(this);

//<editor-fold desc="Data Methods">
  const Club({
    required this.id,
    required this.name,
    required this.win,
    required this.draw,
    required this.loss,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Club &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          win == other.win &&
          draw == other.draw &&
          loss == other.loss);

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      win.hashCode ^
      draw.hashCode ^
      loss.hashCode;

  @override
  String toString() {
    return 'Club{' +
        ' id: $id,' +
        ' name: $name,' +
        ' win: $win,' +
        ' draw: $draw,' +
        ' lose: $loss,' +
        '}';
  }

  Club copyWith({
    int? id,
    String? name,
    int? win,
    int? draw,
    int? lose,
  }) {
    return Club(
      id: id ?? this.id,
      name: name ?? this.name,
      win: win ?? this.win,
      draw: draw ?? this.draw,
      loss: lose ?? this.loss,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'name': this.name,
      'win': this.win,
      'draw': this.draw,
      'lose': this.loss,
    };
  }

  factory Club.fromMap(Map<String, dynamic> map) {
    return Club(
      id: map['id'] as int,
      name: map['name'] as String,
      win: map['win'] as int,
      draw: map['draw'] as int,
      loss: map['lose'] as int,
    );
  }

//</editor-fold>
}