import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/constants/const.dart';
import 'package:open_weather_cubit/cubits/theme/theme_state.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:open_weather_cubit/cubits/weather/weather_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  late final StreamSubscription weatherSubscription;
  final WeatherCubit weatherCubit;
  ThemeCubit({required this.weatherCubit}) : super(ThemeState.initial()) {
    weatherSubscription =
        weatherCubit.stream.listen((WeatherState weatherState) {
      if (weatherState.weather.temperature < kWarmorNot) {
        emit(state.copyWith(themeStatus: ThemeStatus.light));
      } else {
        emit(state.copyWith(themeStatus: ThemeStatus.dartk));
      }
    });
  }
  @override
  Future<void> close() {
    weatherSubscription.cancel();
    return super.close();
  }
}
