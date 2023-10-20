part of 'weather_bloc.dart';

@immutable
abstract class WeatherEvent extends Equatable {

  const WeatherEvent();

  @override
  List<Object> get props=>[];
}


class MyWeatherEvent extends WeatherEvent{
  final Position position;

  const MyWeatherEvent(this.position);

  @override
  List<Object> get props=>[position];
}


class OnClick extends WeatherEvent{
 
}
