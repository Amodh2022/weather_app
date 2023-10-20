import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:weatherapp/weather_screen/bloc/weather_bloc.dart';
import 'package:weatherapp/weather_screen/widgets/widgets.dart';

class WeatherMainPage extends StatefulWidget {
  const WeatherMainPage({super.key});

  @override
  State<WeatherMainPage> createState() => _State();
}

class _State extends State<WeatherMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: BlocBuilder<WeatherBloc, WeatherState>(
          builder: (context, state) {
            if (state is WeatherLoaded) {
              return Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20)),
                  gradient: LinearGradient(
                      colors: [
                        Colors.red,
                        Colors.blue,
                        Colors.purple,
                        Colors.redAccent
                        //add more colors for gradient
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      stops: [0, 0.2, 0.5, 0.8]),
                ),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          FontAwesomeIcons.locationDot,
                          color: Colors.white,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          state.weather.areaName!,
                          style: GoogleFonts.dmSans(
                              fontSize: 26,
                              color: Colors.white,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    SizedBox(
                        height: 300,
                        child: getWeatherIcon(
                            state.weather.weatherConditionCode!)),
                    Text(
                      "${splitC(state.weather.temperature.toString())}°",
                      style: GoogleFonts.dmSans(
                          fontSize: 150,
                          color: Colors.white,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      state.weather.weatherDescription!,
                      style: GoogleFonts.dmSans(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w500),
                    ),
                    Text(
                      date(state.weather.date.toString()),
                      style: GoogleFonts.dmSans(
                          fontSize: 20,
                          color: Colors.grey,
                          fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Icon(
                              FontAwesomeIcons.wind,
                              color: Colors.white,
                            ),
                            Text(
                              "${state.weather.windSpeed.toString()} km/h",
                              style: GoogleFonts.dmSans(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Wind",
                              style: GoogleFonts.dmSans(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              FontAwesomeIcons.droplet,
                              color: Colors.purpleAccent,
                            ),
                            Text(
                              "${state.weather.humidity.toString()} %",
                              style: GoogleFonts.dmSans(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Humidity",
                              style: GoogleFonts.dmSans(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            const Icon(
                              FontAwesomeIcons.cloudRain,
                              color: Colors.white,
                            ),
                            Text(
                              "${state.weather.pressure} hpa",
                              style: GoogleFonts.dmSans(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700),
                            ),
                            Text(
                              "Pressure",
                              style: GoogleFonts.dmSans(
                                  fontSize: 20,
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w500),
                            )
                          ],
                        )
                      ],
                    )
                  ],
                ),
              );
            }
            return Container();
          },
        ));
  }

  String date(String string) {
    List<String> splitting = string.split(' ');
    String splitted = splitting[0];
    var date = DateFormat("EEEE,dd MMM");
    var formatted = date.format(DateTime.parse(splitted));
    return formatted;
  }

  splitC(String string) {
    List<String> splitting = string.split(' ');
    String splitted = splitting[0];
    List<String> secondSplit = splitted.split('.');
    String secondSplitted = secondSplit[0];
    return secondSplitted;
  }
}
