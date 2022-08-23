import 'package:json_annotation/json_annotation.dart';
import 'package:weather_counter/models/coordinate_model.dart';
import 'package:weather_counter/models/sys_model.dart';
import 'package:weather_counter/models/wind_model.dart';
import 'clouds_model.dart';
import 'main_model.dart';
import 'weather_model.dart';

part 'weathers_model.g.dart';

@JsonSerializable(explicitToJson: true)
class Weathers {
  Weathers({
    this.coord,
    this.weather,
    this.base,
    this.main,
    this.visibility,
    this.wind,
    this.clouds,
    this.dt,
    this.sys,
    this.timezone,
    this.id,
    this.name,
    this.cod,
  });

  factory Weathers.fromJson(Map<String, dynamic> json) =>
      _$WeathersFromJson(json);

  Map<String, dynamic> toJson() => _$WeathersToJson(this);

  Coordinate? coord;
  List<Weather>? weather;
  String? base;
  Main? main;
  int? visibility;
  Wind? wind;
  Clouds? clouds;
  int? dt;
  Sys? sys;
  int? timezone;
  int? id;
  String? name;
  int? cod;
}
