import 'package:di_demo/data/city_repo.dart';
import 'package:di_demo/data/city_service.dart';
import 'package:di_demo/data/city_service_mock.dart';
import 'package:di_demo/data/weather_repo.dart';
import 'package:di_demo/data/weather_service.dart';
import 'package:di_demo/data/weather_service_mock.dart';
import 'package:di_demo/presentation/home/home_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  static bool isDebug = false;

  final List<RepositoryProvider<Object>> _provider = [
    RepositoryProvider<WeatherRepo>(
      create: (context) => WeatherRepo(
        isDebug
            ? WeatherServiceMock()
            : WeatherService(
                Dio(),
                baseUrl: "https://api.openweathermap.org",
              ),
      ),
    ),
    RepositoryProvider<CityRepo>(
      create: (context) => CityRepo(
        isDebug
            ? CityServiceMock()
            : CityService(
                Dio(),
                baseUrl: "https://api.openweathermap.org",
              ),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: _provider,
      child: MaterialApp(
        title: 'Weather Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
