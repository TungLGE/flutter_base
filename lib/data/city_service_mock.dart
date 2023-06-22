import 'package:di_demo/data/city_service.dart';
import 'package:di_demo/models/city.dart';

class CityServiceMock implements CityService {
  @override
  Future<List<City>> getCitiesByName(
    String cityName,
    String appid, {
    int limit = 5,
  }) {
    return Future.value([
      City.fromJson({}),
      City.fromJson({}),
    ]);
  }
}
