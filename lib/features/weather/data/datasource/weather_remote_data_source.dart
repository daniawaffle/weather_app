import 'dart:developer';

import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/core/errors/exceptions.dart';
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/features/weather/data/model/weather_model.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getCurrentWeather(double latitude, double longitude);
}

class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiClient apiClient;

  WeatherRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<WeatherModel> getCurrentWeather(
      double latitude, double longitude) async {
    try {
      final params = {
        'latitude': latitude.toString(),
        'longitude': longitude.toString(),
        'current': 'temperature_2m,wind_speed_10m,weather_code',
        'timezone': 'auto',
      };

      final response = await apiClient.get(
        '${AppConstants.baseUrl}${AppConstants.weatherEndpoint}',
        params: params,
      );
      return WeatherModel.fromJson(response);
    } on ServerException {
      rethrow;
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
