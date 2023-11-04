import 'package:weather_app/model/weather/weather_daily_data.dart';
import 'package:weather_app/model/weather/weather_data_current_data.dart';
import 'package:weather_app/model/weather/weather_hourly_data.dart';

class WeatherData {
  final WeatherDataCurrent? current;
  final WeatherDataHourly? hourly;
  final WeatherDataDaily? daily;
  WeatherData([this.current, this.hourly, this.daily]);

  WeatherDataCurrent getCurrentWeather() => current!;
  WeatherDataHourly getHourlyWeather() => hourly!;
  WeatherDataDaily getDailyWether() => daily!;
}
