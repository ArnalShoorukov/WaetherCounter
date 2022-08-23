import 'package:json_annotation/json_annotation.dart';

part 'wind_model.g.dart';

@JsonSerializable()
class Wind {

  Wind(
      { this.speed,
        this.deg,
        this.gust
      });


  factory Wind.fromJson(Map<String, dynamic> json) => _$WindFromJson(json);

  Map<String, dynamic> toJson() => _$WindToJson(this);

  double? speed;
  int? deg;
  double? gust;
}