import 'dart:async';

import 'package:di_demo/data/city_repo.dart';
import 'package:di_demo/data/weather_repo.dart';
import 'package:di_demo/models/city.dart';
import 'package:di_demo/models/weather.dart';
import 'package:di_demo/util/presentation_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@immutable
class HomeState {
  final DataState state;
  final Weather? weather;
  final City? city;

  const HomeState({
    required this.state,
    required this.weather,
    required this.city,
  });

  factory HomeState.init() =>
      const HomeState(state: DataState.init, weather: null, city: null);

  HomeState copyWith({
    DataState? state,
    Weather? weather,
    City? city,
  }) =>
      HomeState(
        state: state ?? this.state,
        weather: weather ?? this.weather,
        city: city ?? this.city,
      );
}

@injectable
class HomeCubit extends Cubit<HomeState> {
  final WeatherRepo _weatherRepo;
  final CityRepo _cityRepo;
  Timer? _timer;

  HomeCubit(this._weatherRepo, this._cityRepo) : super(HomeState.init());

  void getWeatherInHaNoi() async {
    emit(state.copyWith(state: DataState.loading));

    _weatherRepo.getWeatherByLocation(21.028511, 105.804817).then((value) {
      emit(
        state.copyWith(
          state: DataState.success,
          weather: value,
          city: City(name: "Hanoi"),
        ),
      );
    }).onError((error, stackTrace) {
      emit(state.copyWith(state: DataState.fail, weather: null));
    });
  }

  void searchCity(String name) async {
    emit(state.copyWith(state: DataState.loading));
    _timer?.cancel();
    _timer = Timer(const Duration(milliseconds: 500), () async {
      try {
        var city = (await _cityRepo.searchCity(name)).first;
        if (city == null) {
          throw Exception("City not existed");
        }
        var weather = await _weatherRepo.getWeatherByLocation(
            city.lat ?? 0, city.lon ?? 0);
        emit(state.copyWith(
          state: DataState.success,
          weather: weather,
          city: city,
        ));
      } catch (e) {
        emit(state.copyWith(state: DataState.fail, weather: null, city: null));
      }
    });
  }
}
