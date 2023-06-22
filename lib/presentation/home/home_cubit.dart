import 'package:di_demo/data/city_repo.dart';
import 'package:di_demo/data/weather_repo.dart';
import 'package:di_demo/models/weather.dart';
import 'package:di_demo/util/presentation_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@immutable
class HomeState {
  final DataState state;
  final Weather? weather;

  const HomeState({required this.state, required this.weather});

  factory HomeState.init() =>
      const HomeState(state: DataState.init, weather: null);

  HomeState copyWith({DataState? state, Weather? weather}) => HomeState(
        state: state ?? this.state,
        weather: weather ?? this.weather,
      );
}

class HomeCubit extends Cubit<HomeState> {
  final WeatherRepo _weatherRepo;
  final CityRepo _cityRepo;

  HomeCubit(this._weatherRepo, this._cityRepo) : super(HomeState.init());

  void getWeatherInHaNoi() async {
    emit(state.copyWith(state: DataState.loading));

    _weatherRepo.getWeatherByLocation(21.028511, 105.804817).then((value) {
      emit(state.copyWith(state: DataState.success, weather: value));
    }).onError((error, stackTrace) {
      emit(state.copyWith(state: DataState.fail, weather: null));
    });
  }

  void searchCity(String name) async {
    emit(state.copyWith(state: DataState.loading));

    try {
      var city = (await _cityRepo.searchCity(name)).first;
      var weather = await _weatherRepo.getWeatherByLocation(
          city.lat ?? 0, city.lon ?? 0);
      emit(state.copyWith(state: DataState.success, weather: weather));
    } catch(e) {
      emit(state.copyWith(state: DataState.fail, weather: null));
    }
  }
}
