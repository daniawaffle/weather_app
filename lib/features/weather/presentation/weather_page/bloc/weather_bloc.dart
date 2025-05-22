import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/core/errors/failures.dart';
import 'package:weather_app/features/weather/domain/entities/weather.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';

part 'weather_event.dart';
part 'weather_state.dart';
part 'weather_bloc.freezed.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetCurrentWeather getCurrentWeather;

  WeatherBloc({required this.getCurrentWeather})
      : super(const WeatherState.initial()) {
    on<WeatherEvent>((event, emit) async {
      await event.map(
        fetchWeather: (e) => _onFetchWeather(e, emit),
        fetchWeatherWithLocation: (e) => _onFetchWeatherWithLocation(e, emit),
      );
    });
  }

  Future<void> _onFetchWeather(
    FetchWeather event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherState.loading());
    final result = await getCurrentWeather(event.latitude, event.longitude);
    result.fold(
      (failure) => emit(WeatherState.error(_mapFailureToMessage(failure))),
      (weather) => emit(WeatherState.loaded(weather)),
    );
  }

  Future<void> _onFetchWeatherWithLocation(
    FetchWeatherWithLocation event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherState.loading());
    try {
      final result = await getCurrentWeather(event.latitude, event.longitude);
      result.fold(
        (failure) => emit(WeatherState.error(_mapFailureToMessage(failure))),
        (weather) => emit(WeatherState.loaded(weather)),
      );
    } catch (e) {
      emit(WeatherState.error(e.toString()));
    }
  }

  String _mapFailureToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return 'Server error: ${failure.message}';
      case LocationFailure:
        return 'Location error: ${failure.message}';
      default:
        return 'Unexpected error: ${failure.message}';
    }
  }
}
