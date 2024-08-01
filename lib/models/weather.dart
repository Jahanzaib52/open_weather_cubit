import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String description;
  final String icon;
  final double temperature;
  final double tempMin;
  final double tempMax;
  final String cityName;
  final String country;
  final DateTime lastUpdated;
  const Weather({
    required this.description,
    required this.icon,
    required this.temperature,
    required this.tempMin,
    required this.tempMax,
    required this.cityName,
    required this.country,
    required this.lastUpdated,
  });
  factory Weather.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> weather = json["weather"][0];
    final Map<String, dynamic> main = json["main"];
    return Weather(
      description: weather["description"],
      icon: weather["icon"],
      temperature: main["temp"],
      tempMin: main["temp_min"],
      tempMax: main["temp_max"],
      cityName: "",
      country: "",
      lastUpdated: DateTime.now(),
    );
  }
  factory Weather.initial() {
    return Weather(
      description: "",
      icon: "",
      temperature: 100,
      tempMin: 100,
      
      tempMax: 100,
      cityName: "",
      country: "country",
      lastUpdated: DateTime(1970),
    );
  }
  @override
  List<Object> get props =>
      [description, icon, temperature, tempMin, tempMax, lastUpdated];
  Weather copyWith({
    String? description,
    String? icon,
    double? temperature,
    double? tempMin,
    double? tempMax,
    String? cityName,
    String? country,
    DateTime? lastUpdated,
  }) {
    return Weather(
      description: description ?? this.description,
      icon: icon ?? this.icon,
      temperature: temperature ?? this.temperature,
      tempMin: tempMin ?? this.tempMin,
      tempMax: tempMax ?? this.tempMax,
      cityName: cityName ?? this.cityName,
      country: country ?? this.country,
      lastUpdated: lastUpdated ?? this.lastUpdated,
    );
  }
}
