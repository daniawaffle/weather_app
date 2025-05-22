import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';

class WeatherDisplay extends StatelessWidget {
  final WeatherEntity weather;

  const WeatherDisplay({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    final dateTime = DateTime.parse(weather.time);
    final formattedDate = DateFormat('MMM dd, yyyy').format(dateTime);
    final formattedTime = DateFormat('HH:mm').format(dateTime);

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          '${weather.temperature.toStringAsFixed(1)}°C',
          style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          weather.weatherCondition,
          style: const TextStyle(fontSize: 24),
        ),
        const SizedBox(height: 8),
        Text(
          'Wind: ${weather.windSpeed.toStringAsFixed(1)} km/h',
          style: const TextStyle(fontSize: 18),
        ),
        const SizedBox(height: 24),
        Text(
          formattedDate,
          style: const TextStyle(fontSize: 16),
        ),
        Text(
          formattedTime,
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}
