import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/cubits/weather/weather_state.dart';
import 'package:open_weather_cubit/models/custom_error.dart';
import 'package:open_weather_cubit/models/weather.dart';
import 'package:open_weather_cubit/repositories/weather_repository.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository weatherRepository;
  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());
  Future<void> fetchWeather(String cityName) async {
    emit(state.copyWith(weatherStatus: WeatherStatus.loading));
    try {
      final Weather weather = await weatherRepository.fetchWeather(cityName);
      emit(state.copyWith(
          weatherStatus: WeatherStatus.loaded, weather: weather));
    } on CustomError catch (e) {
      emit(state.copyWith(weatherStatus: WeatherStatus.error, error: e));
    }
  }
}
