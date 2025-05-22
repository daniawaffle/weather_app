part of 'weather_bloc.dart';

@freezed
class WeatherState with _$WeatherState {
  const factory WeatherState.initial() = WeatherInitial;
  const factory WeatherState.loading() = WeatherLoading;
  const factory WeatherState.loaded(WeatherEntity weather) = WeatherLoaded;
  const factory WeatherState.error(String message) = WeatherError;
}
