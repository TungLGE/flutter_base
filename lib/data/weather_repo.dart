import 'package:di_demo/data/weather_service.dart';
import 'package:di_demo/models/weather.dart';

class WeatherRepo {
  final WeatherService _service;

  WeatherRepo(this._service);

  Future<Weather> getWeatherByLocation(double lat, double lon) =>
      _service.getWeatherByLocation(lat, lon, "1f930c31692eff97a92281d72455c44a");
}
