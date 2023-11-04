import 'dart:convert';
import 'package:weather_app/model/weather/weather_daily_data.dart';
import 'package:weather_app/model/weather/weather_hourly_data.dart';

import '../utils/api_url.dart';
import 'package:weather_app/model/weather/weather_data_current_data.dart';
import 'package:weather_app/model/weather_data.dart';
import 'package:http/http.dart' as http;

class FeatchWeatherAPI {
  WeatherData? weatherData;

  //processing the data from Response -> JSON;

  Future<WeatherData> processData(double lat, double lon) async {
    var response = await http.get(Uri.parse(apiUrl(lat, lon)));
    var jsonString = jsonDecode(response.body);
    weatherData = WeatherData(
        WeatherDataCurrent.fromJson(jsonString),
        WeatherDataHourly.fromJson(jsonString),
        WeatherDataDaily.fromJson(jsonString));

    return weatherData!;
  }
}
