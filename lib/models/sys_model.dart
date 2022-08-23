import 'package:json_annotation/json_annotation.dart';

part 'sys_model.g.dart';

@JsonSerializable()
class Sys {

  Sys(
      { this.type,
        this.id,
        this.country,
        this.sunrise,
        this.sunset,
      });


  factory Sys.fromJson(Map<String, dynamic> json) => _$SysFromJson(json);

  Map<String, dynamic> toJson() => _$SysToJson(this);

  int? type;
  int? id;
  String? country;
  int? sunrise;
  int? sunset;
}