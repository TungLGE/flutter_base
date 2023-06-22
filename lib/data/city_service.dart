import 'package:di_demo/models/city.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'city_service.g.dart';

@RestApi()
abstract class CityService {
  factory CityService(Dio dio, {String baseUrl}) = _CityService;

  @GET("/geo/1.0/direct")
  Future<List<City>> getCitiesByName(
      @Query("q") String cityName,
      @Query("appid") String appid, {
        @Query("limit") int limit = 5,
      });
}
