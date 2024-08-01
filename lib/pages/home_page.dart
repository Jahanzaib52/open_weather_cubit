import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/cubits/temp_unit/temp_unit_cubit.dart';
import 'package:open_weather_cubit/cubits/temp_unit/temp_unit_state.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:open_weather_cubit/cubits/weather/weather_state.dart';
import 'package:open_weather_cubit/pages/search_page.dart';
import 'package:open_weather_cubit/pages/settings_page.dart';
import 'package:open_weather_cubit/widgets/error_dialog.dart';
import 'package:recase/recase.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? cityName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
            onPressed: () async {
              cityName = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
              if (cityName != null) {
                if (!context.mounted) return;
                context.read<WeatherCubit>().fetchWeather(cityName!);
              }
            },
            icon: const Icon(Icons.search),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
      body: showWeather(),
    );
  }

  Widget showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      listener: (context, state) {
        if (state.weatherStatus == WeatherStatus.error) {
          errorDialog(
            context,
            state.error.errMsg,
          );
        }
      },
      builder: (context, state) {
        if (state.weatherStatus == WeatherStatus.initial) {
          return const Center(
            child: Text("Select City"),
          );
        }
        if (state.weatherStatus == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state.weatherStatus == WeatherStatus.error &&
            state.weather.cityName == "") {
          return const Center(
            child: Text("Select City"),
          );
        }
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
            ),
            Text(
              state.weather.cityName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  TimeOfDay.fromDateTime(state.weather.lastUpdated)
                      .format(context),
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  state.weather.country,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  showTemperature(state.weather.temperature),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  children: [
                    Text(
                      showTemperature(state.weather.tempMax),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    Text(
                      showTemperature(state.weather.tempMin),
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInImage.assetNetwork(
                  placeholder: "assets/images/loading.gif",
                  image:
                      "https://openweathermap.org/img/wn/${state.weather.icon}@4x.png",
                  width: 96,
                  height: 96,
                ),
                const SizedBox(
                  width: 25,
                ),
                Text(
                  state.weather.description.titleCase,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  String showTemperature(double temperature) {
    final tempUnit =
        context.watch<TemperatureUnitCubit>().state.temperatureUnit;
    if (tempUnit == TemperatureUnit.farenheit) {
      return "${((temperature * 9 / 5) + 32).toStringAsFixed(1)}°F";
    }
    return "${temperature.toStringAsFixed(1)}°C";
  }
}
