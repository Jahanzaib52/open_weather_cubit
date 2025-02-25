import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_cubit/Exceptions/weather_exception.dart';
import 'package:open_weather_cubit/constants/const.dart';
import 'package:open_weather_cubit/models/direct_geocoding.dart';
import 'package:open_weather_cubit/models/weather.dart';
import 'package:open_weather_cubit/services/http_error_handler.dart';

class WeatherApiServices {
  final http.Client httpClient;
  WeatherApiServices({required this.httpClient});
  Future<DirectGeocoding> getDirectGeocoding(String cityName) async {
    final Uri uri = Uri(
      scheme: "http",
      host: kApiHost,
      path: "/geo/1.0/direct",
      queryParameters: {
        "q": cityName,
        "limit": kLimit,
        "appid": dotenv.env["APPID"],
      },
    );
    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final responseBody = json.decode(response.body);
      if (responseBody.isEmpty) {
        throw WeatherException(
          message: "Cannot get Location of $cityName",
        );
      }
      final directGeocoding = DirectGeocoding.fromJson(responseBody);
      return directGeocoding;
    } catch (e) {
      rethrow;
    }
  }

  Future<Weather> getWeather(DirectGeocoding directGeocoding) async {
    final Uri uri = Uri(
      scheme: "https",
      host: kApiHost,
      path: "/data/2.5/weather",
      queryParameters: {
        "lat": "${directGeocoding.lat}",
        "lon": "${directGeocoding.lon}",
        "appid": dotenv.env["APPID"],
        "units": kUnit,
      },
    );
    try {
      final http.Response response = await httpClient.get(uri);
      if (response.statusCode != 200) {
        throw httpErrorHandler(response);
      }
      final resposeBody = json.decode(response.body);
      final Weather weather = Weather.fromJson(resposeBody);
      return weather;
    } catch (e) {
      rethrow;
    }
  }
}
