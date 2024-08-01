import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/cubits/temp_unit/temp_unit_cubit.dart';
import 'package:open_weather_cubit/cubits/temp_unit/temp_unit_state.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: ListTile(
        title: const Text("Temperature Unit"),
        subtitle: const Text("Celsius/Farenheit(Default: Celsius)"),
        trailing: Switch(
          value: context.watch<TemperatureUnitCubit>().state.temperatureUnit ==
              TemperatureUnit.celsius,
          onChanged: (_) {
            context.read<TemperatureUnitCubit>().toggleTemperatureUnit();
          },
        ),
      ),
    );
  }
}
