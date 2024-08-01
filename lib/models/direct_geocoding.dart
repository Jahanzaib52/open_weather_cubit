import 'package:equatable/equatable.dart';

class DirectGeocoding extends Equatable {
  final String cityName;
  final String country;
  final double lat;
  final double lon;
  const DirectGeocoding({
    required this.cityName,
    required this.country,
    required this.lat,
    required this.lon,
  });
  factory DirectGeocoding.fromJson(List<dynamic> json) {
    Map<String, dynamic> data = json[0];
    return DirectGeocoding(
      cityName: data["name"],
      country: data["country"],
      lat: data["lat"],
      lon: data["lon"],
    );
  }
  @override
  List<Object> get props => [cityName, country, lat, lon];
}
