import 'package:di_demo/data/city_service.dart';
import 'package:di_demo/models/city.dart';
import 'package:injectable/injectable.dart';

@injectable
class CityRepo {
  final CityService _service;

  CityRepo(this._service);

  Future<List<City>> searchCity(String cityName) =>
      _service.getCitiesByName(cityName, "1f930c31692eff97a92281d72455c44a");
}
