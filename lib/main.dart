import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weatherapp/weather_screen/bloc/weather_bloc.dart';
import 'package:weatherapp/weather_screen/weather_main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _determinePosition(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Weather App',
              home: Scaffold(
                body: SafeArea(
                  child: BlocProvider<WeatherBloc>(
                    create: (context) => WeatherBloc()
                      ..add(MyWeatherEvent(snapshot.data as Position)),
                    child: const WeatherMainPage(),
                  ),
                ),
              ));
        } else {
          return const MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              backgroundColor: Colors.white,
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    return await Geolocator.getCurrentPosition();
  }
}
