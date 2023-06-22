import 'package:di_demo/models/weather.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'weather_service.g.dart';

@RestApi()
abstract class WeatherService {
  factory WeatherService(Dio dio, {String baseUrl}) = _WeatherService;

  @GET("/data/2.5/weather")
  Future<Weather> getWeatherByLocation(
      @Query("lat") double? lat,
      @Query("lon") double? lon,
      @Query("appid") String appid,
      );
}
