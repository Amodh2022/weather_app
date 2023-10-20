import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';


part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<MyWeatherEvent>((event, emit) async{
      emit(WeatherLoading());
      try{
        WeatherFactory wf =  WeatherFactory("c8e78769eee717a40492cf8baa74253d", language: Language.ENGLISH);
        Weather weather=await wf.currentWeatherByLocation(event.position.latitude, event.position.longitude);
        emit(WeatherLoaded(weather));

      }catch(e){
        emit(const WeatherError("Could Not Load The Event"));
      }




    });
    on<OnClick>((event, emit) async{
      print("object");



    });

    
  }
}
