import 'package:get_it/get_it.dart';
import 'package:weather_counter/managers/weather_manager.dart';
import 'package:weather_counter/services/weather_service.dart';


GetIt sl = GetIt.instance;

void setUpServiceLocator() {
  // register services
  sl.registerLazySingleton<WeatherService>(() => WeatherServiceImplementation());


  // register managers
  sl.registerLazySingleton<WeatherManagers>(() => WeatherManagers());


}

