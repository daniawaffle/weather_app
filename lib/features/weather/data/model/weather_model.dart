import 'package:weather_app/features/weather/domain/entities/weather.dart';

class WeatherModel extends WeatherEntity {
  const WeatherModel({
    required double temperature,
    required double windSpeed,
    required int weatherCode,
    required String time,
  }) : super(
          temperature: temperature,
          windSpeed: windSpeed,
          weatherCode: weatherCode,
          time: time,
        );

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      temperature: json['current']['temperature_2m'],
      windSpeed: json['current']['wind_speed_10m'],
      weatherCode: json['current']['weather_code'],
      time: json['current']['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'temperature': temperature,
      'windSpeed': windSpeed,
      'weatherCode': weatherCode,
      'time': time,
    };
  }
}
