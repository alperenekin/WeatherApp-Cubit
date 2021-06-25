import 'package:bloc/bloc.dart';
import 'package:flutter_cubit_bloc_tutorial/data/model/weather.dart';
import 'package:flutter_cubit_bloc_tutorial/data/weather_repository.dart';
import 'package:meta/meta.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> { //getting the weather from repository and emitting the states
  final WeatherRepository _weatherRepository; //dependency injection part
  WeatherCubit(this._weatherRepository) : super(WeatherInitial());

  Future<void> getWeather(String cityName) async{
    try{
      emit(const WeatherLoading());
      final weather = await _weatherRepository.fetchWeather(cityName);
      emit(WeatherLoaded(weather));
    } on NetworkException{
      emit(WeatherError("Could not fetch the weather"));
    }

  }
}
