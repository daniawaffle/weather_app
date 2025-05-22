part of 'weather_bloc.dart';

@freezed
class WeatherEvent with _$WeatherEvent {
  const factory WeatherEvent.fetchWeather({
    required double latitude,
    required double longitude,
  }) = FetchWeather;

  const factory WeatherEvent.fetchWeatherWithLocation({
    required double latitude,
    required double longitude,
  }) = FetchWeatherWithLocation;
}
