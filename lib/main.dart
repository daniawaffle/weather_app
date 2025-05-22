import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_app/features/weather/presentation/weather_page/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/weather_page/weather_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) {
              final client = http.Client();
              final apiClient = ApiClient(client: client);
              final remoteDataSource =
                  WeatherRemoteDataSourceImpl(apiClient: apiClient);
              final networkInfo = NetworkInfoImpl();
              final repository = WeatherRepositoryImpl(
                remoteDataSource: remoteDataSource,
                networkInfo: networkInfo,
              );
              final getCurrentWeather = GetCurrentWeather(repository);
              return WeatherBloc(getCurrentWeather: getCurrentWeather);
            },
          ),
        ],
        child: const WeatherPage(),
      ),
    );
  }
}
