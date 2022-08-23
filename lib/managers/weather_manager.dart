import 'package:rxdart/rxdart.dart';
import 'package:weather_counter/models/weathers_model.dart';

import '../helpers/weather_command.dart';
import '../service_locator.dart';
import '../services/weather_service.dart';

class WeatherManagers {
  WeatherManagers() {
    _requestSubject.listen((value) {
      _getWeathers().listen((event) {
        logger.d(event);
        _weathers.add(event);
      });
    });
  }

  final PublishSubject<RequestCommand> _requestSubject =
      PublishSubject<RequestCommand>();
  final BehaviorSubject<Weathers> _weathers = BehaviorSubject<Weathers>();

  Sink<RequestCommand> get inRequest => _requestSubject.sink;

  Stream<Weathers> get weather$ => _weathers.stream;

  Stream<Weathers> _getWeathers() {
    return Stream.fromFuture(sl<WeatherService>().getWeathers());
  }

  void dispose() {
    _weathers.close();
    _requestSubject.close();
  }
}
