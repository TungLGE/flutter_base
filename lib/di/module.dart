import 'package:di_demo/data/city_service.dart';
import 'package:di_demo/data/city_service_mock.dart';
import 'package:di_demo/data/weather_service.dart';
import 'package:di_demo/data/weather_service_mock.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@module
abstract class DataModule {
  @lazySingleton
  Dio get dio {
    final Dio dio = Dio();
    return dio;
  }

  @Injectable(env: [Environment.prod])
  WeatherService get weatherServiceProd {
    return WeatherService(
      Dio(),
      baseUrl: "https://api.openweathermap.org",
    );
  }

  @Injectable(env: [Environment.dev])
  WeatherService get weatherServiceDev {
    return WeatherServiceMock();
  }

  @Injectable(env: [Environment.prod])
  CityService get cityServiceProd {
    return CityService(
      Dio(),
      baseUrl: "https://api.openweathermap.org",
    );
  }

  @Injectable(env: [Environment.dev])
  CityService get cityServiceDev {
    return CityServiceMock();
  }
}
