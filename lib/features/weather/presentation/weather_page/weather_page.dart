import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/constants/app_constants.dart';
import 'package:weather_app/core/utils/location_utils.dart';
import 'package:weather_app/features/weather/presentation/weather_page/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/weather_page/widgets/weather_display.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: () async {
              try {
                final position = await LocationUtil.getCurrentPosition();
                context.read<WeatherBloc>().add(
                      WeatherEvent.fetchWeatherWithLocation(
                        latitude: position.latitude,
                        longitude: position.longitude,
                      ),
                    );
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(e.toString())),
                );
              }
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            return state.when(
              initial: () {
                context.read<WeatherBloc>().add(
                      const WeatherEvent.fetchWeather(
                        latitude: AppConstants.defaultLatitude,
                        longitude: AppConstants.defaultLongitude,
                      ),
                    );
                return const CircularProgressIndicator();
              },
              loading: () => const CircularProgressIndicator(),
              loaded: (weather) => WeatherDisplay(weather: weather),
              error: (message) => Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(message),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<WeatherBloc>().add(
                            const WeatherEvent.fetchWeather(
                              latitude: AppConstants.defaultLatitude,
                              longitude: AppConstants.defaultLongitude,
                            ),
                          );
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
