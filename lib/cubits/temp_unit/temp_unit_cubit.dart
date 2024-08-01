import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/cubits/temp_unit/temp_unit_state.dart';

class TemperatureUnitCubit extends Cubit<TemperatureUnitState> {
  TemperatureUnitCubit() : super(TemperatureUnitState.initial());
  void toggleTemperatureUnit() {
    emit(
      state.copyWith(
        temperatureUnit: state.temperatureUnit == TemperatureUnit.celsius
            ? TemperatureUnit.farenheit
            : TemperatureUnit.celsius,
      ),
    );
  }
}
