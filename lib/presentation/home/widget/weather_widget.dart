import 'package:di_demo/models/city.dart';
import 'package:di_demo/models/weather.dart';
import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;
  final City city;

  const WeatherWidget({super.key, required this.weather, required this.city});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "The weather in ${city.getFullName()} right now",
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(weather.weathers?.first.main ?? ""),
          Text(weather.weathers?.first.description ?? ""),
          Text("Temperature: ${weather.main?.temp} F"),
          Text("Humidity: ${weather.main?.humidity} %"),
          Text("Pressure: ${weather.main?.pressure} Pa"),
        ],
      ),
    );
  }
}
