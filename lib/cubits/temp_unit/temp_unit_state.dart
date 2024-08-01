import 'package:equatable/equatable.dart';

enum TemperatureUnit {
  celsius,
  farenheit,
}

class TemperatureUnitState extends Equatable {
  final TemperatureUnit temperatureUnit;
  const TemperatureUnitState({required this.temperatureUnit});
  factory TemperatureUnitState.initial() {
    return const TemperatureUnitState(
      temperatureUnit: TemperatureUnit.celsius,
    );
  }
  @override
  List<Object> get props => [temperatureUnit];
  TemperatureUnitState copyWith({TemperatureUnit? temperatureUnit}) {
    return TemperatureUnitState(
      temperatureUnit: temperatureUnit ?? this.temperatureUnit,
    );
  }
}
