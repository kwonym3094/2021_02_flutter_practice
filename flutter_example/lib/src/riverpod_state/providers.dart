// WeatherRepository를 위한 provider 만들기

import 'package:flutter_example/src/riverpod_state/application/weather_notifier.dart';
import 'package:flutter_example/src/riverpod_state/infrastructure/weather_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1.
final weatherRepositoryProvider = Provider<WeatherRepository>(
  (ref) => FakeWeatherRepository(),
);

// 2.
final weatherNotifierProvider = StateNotifierProvider(
    (ref) => WeatherNotifier(ref.watch(weatherRepositoryProvider)));
