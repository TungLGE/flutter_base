import 'package:di_demo/models/weather.dart';
import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  final Weather weather;

  const WeatherWidget({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "The weather in Hanoi right now",
            style: TextStyle(
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
