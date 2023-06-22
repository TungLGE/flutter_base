import 'package:di_demo/data/weather_service.dart';
import 'package:di_demo/models/weather.dart';

class WeatherServiceMock implements WeatherService {
  @override
  Future<Weather> getWeatherByLocation(
    double? lat,
    double? lon,
    String appid,
  ) {
    return Future.value(Weather.fromJson({}));
  }
}
