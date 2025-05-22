import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:weather_app/core/di/injection_container.dart' as di;
import 'package:weather_app/features/weather/presentation/weather_page/bloc/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/weather_page/weather_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
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
            create: (context) => di.sl<WeatherBloc>(),
          ),
        ],
        child: const WeatherPage(),
      ),
    );
  }
}
