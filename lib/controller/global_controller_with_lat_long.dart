import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/api/featch_weather.dart';
import 'package:weather_app/model/weather_data.dart';

class GlobalController extends GetxController {
  //STEP 1 create various variables;

  final RxBool _isLoading = true.obs;
  final RxDouble lattitude;
  final RxDouble longitude;
  final weatherData = WeatherData().obs;
  final RxInt _currentIndex = 0.obs;
  //STEP2 create instance for them to be called

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => lattitude;
  RxDouble getLongitude() => longitude;
  WeatherData getWeatherData() => weatherData.value;

  GlobalController({
    required this.lattitude,
    required this.longitude,
  }) {
    getLocation();
  }

  @override
  void onInit() {
    if (_isLoading.isTrue) {
      getLocation();
    } else {
      getIndex();
    }

    super.onInit();
  }

  getLocation() async {
    //calling our weather API

    return FeatchWeatherAPI()
        .processData(lattitude.value, longitude.value)
        .then((value) {
      weatherData.value = value;
      _isLoading.value = false;
    });
  }

  RxInt getIndex() => _currentIndex;
}
