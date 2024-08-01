import 'package:open_weather_cubit/Exceptions/weather_exception.dart';
import 'package:open_weather_cubit/models/custom_error.dart';
import 'package:open_weather_cubit/models/direct_geocoding.dart';
import 'package:open_weather_cubit/models/weather.dart';
import 'package:open_weather_cubit/services/weather_api_services.dart';

class WeatherRepository {
  final WeatherApiServices weatherApiServices;
  WeatherRepository({required this.weatherApiServices});
  Future<Weather> fetchWeather(String cityName) async {
    try {
      final DirectGeocoding directGeocoding =
          await weatherApiServices.getDirectGeocoding(cityName);
      final Weather temporaryWeather =
          await weatherApiServices.getWeather(directGeocoding);
      final Weather weather = temporaryWeather.copyWith(
        cityName: directGeocoding.cityName,
        country: directGeocoding.country,
      );
      return weather;
    } on WeatherException catch (e) {
      throw CustomError(
        errMsg: e.message,
      );
    } catch (e) {
      throw CustomError(errMsg: e.toString());
    }
  }
}
