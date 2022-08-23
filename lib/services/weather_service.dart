import 'dart:convert';

import 'package:http/http.dart';
import 'package:logger/logger.dart';

import '../helpers/helpers.dart';
import '../models/weathers_model.dart';

var logger = Logger();

abstract class WeatherService {
  Future<Weathers> getWeathers();
}

class WeatherServiceImplementation implements WeatherService {
  @override
  Future<Weathers> getWeathers() async {
    Map<String, String> queryParams = {
      'appid': '9df005a74159fe49544a032c4d0f1fa0',
      'lat': '42.882004',
      'lon': '74.582748',
      'units': 'imperial',
    };
    final _uri = Uri.https(Helpers.authority, Helpers.path, queryParams);
    logger.d(_uri);
    print(_uri);
    final response = await get(_uri, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });

    logger.d(response.body.toString());
    logger.d(response.statusCode);

    try {
      if (response.statusCode == 200) {

        final items = jsonDecode(response.body);
        logger.d(items);
       // final json = jsonDecode(items);
        logger.d(json);

        final weathers = Weathers.fromJson(items);

        logger.d(weathers.name);
        return weathers;
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      throw Exception(e);
    }
    throw UnimplementedError();
  }
}
