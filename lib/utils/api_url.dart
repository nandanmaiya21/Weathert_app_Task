import '../api/api_key.dart';

String apiUrl(var lat, var lon) {
  String url =
      "https://api.openweathermap.org/data/3.0/onecall?lat=$lat&lon=$lon&appid=$akiKey&units=metric&exclude=minutely";
  return url;
}
