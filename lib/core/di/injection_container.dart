import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/core/network/network_info.dart';
import 'package:weather_app/core/utils/location_utils.dart';
import 'package:weather_app/features/weather/data/datasource/weather_remote_data_source.dart';
import 'package:weather_app/features/weather/data/repositories/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repositories/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_current_weather.dart';
import 'package:weather_app/features/weather/presentation/weather_page/bloc/weather_bloc.dart';

//Service Locator
final sl = GetIt.instance;

Future<void> init() async {
  // Features - Weather
  // Bloc
  sl.registerFactory(
    () => WeatherBloc(getCurrentWeather: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetCurrentWeather(sl()));

  // Repository
  sl.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: sl(),
      networkInfo: sl(),
    ),
  );

  // Data sources
  sl.registerLazySingleton<WeatherRemoteDataSource>(
    () => WeatherRemoteDataSourceImpl(apiClient: sl()),
  );

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  sl.registerLazySingleton(() => ApiClient(client: sl()));
  sl.registerLazySingleton(() => LocationUtil());

  // External
  sl.registerLazySingleton(() => http.Client());
}
