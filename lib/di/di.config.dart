// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:di_demo/data/city_repo.dart' as _i6;
import 'package:di_demo/data/city_service.dart' as _i3;
import 'package:di_demo/data/weather_repo.dart' as _i7;
import 'package:di_demo/data/weather_service.dart' as _i5;
import 'package:di_demo/di/module.dart' as _i9;
import 'package:di_demo/presentation/home/home_cubit.dart' as _i8;
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

const String _prod = 'prod';
const String _dev = 'dev';

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt $initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  final dataModule = _$DataModule();
  gh.factory<_i3.CityService>(
    () => dataModule.cityServiceProd,
    registerFor: {_prod},
  );
  gh.factory<_i3.CityService>(
    () => dataModule.cityServiceDev,
    registerFor: {_dev},
  );
  gh.lazySingleton<_i4.Dio>(() => dataModule.dio);
  gh.factory<_i5.WeatherService>(
    () => dataModule.weatherServiceProd,
    registerFor: {_prod},
  );
  gh.factory<_i5.WeatherService>(
    () => dataModule.weatherServiceDev,
    registerFor: {_dev},
  );
  gh.factory<_i6.CityRepo>(() => _i6.CityRepo(gh<_i3.CityService>()));
  gh.factory<_i7.WeatherRepo>(() => _i7.WeatherRepo(gh<_i5.WeatherService>()));
  gh.factory<_i8.HomeCubit>(() => _i8.HomeCubit(
        gh<_i7.WeatherRepo>(),
        gh<_i6.CityRepo>(),
      ));
  return getIt;
}

class _$DataModule extends _i9.DataModule {}
