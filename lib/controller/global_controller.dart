import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:weather_app/api/featch_weather.dart';
import 'package:weather_app/model/weather_data.dart';

class GlobalController extends GetxController {
  //STEP 1 create various variables;

  final RxBool _isLoading = true.obs;
  final RxDouble _lattitude = 0.0.obs;
  final RxDouble _longitude = 0.0.obs;
  final weatherData = WeatherData().obs;
  final RxInt _currentIndex = 0.obs;
  //STEP2 create instance for them to be called

  RxBool checkLoading() => _isLoading;
  RxDouble getLattitude() => _lattitude;
  RxDouble getLongitude() => _longitude;
  WeatherData getWeatherData() => weatherData.value;

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
    bool isLocationServiceEnabled;
    LocationPermission locationPermission;
    isLocationServiceEnabled = await Geolocator.isLocationServiceEnabled();

    //return error is isLocationServiceEnabled is not enabled ie, it is false
    if (!isLocationServiceEnabled) {
      return Future.error("Location services is not enabled");
    }

    locationPermission = await Geolocator.checkPermission();

    // if locationPermission is deniedForever then return error
    if (locationPermission == LocationPermission.deniedForever) {
      return Future.error("Location Permission are denied for every");
    } else if (locationPermission == LocationPermission.denied) {
      //request for new permission
      locationPermission = await Geolocator.requestPermission();

      if (locationPermission == LocationPermission.denied) {
        return Future.error("Permisson Denied");
      }
    }

    //Getting the current position of the User
    return await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((value) {
      //Update our lattitude and logitude
      _lattitude.value = value.latitude;
      _longitude.value = value.longitude;

      //calling our weather API
      return FeatchWeatherAPI()
          .processData(value.latitude, value.longitude)
          .then((value) {
        weatherData.value = value;
        _isLoading.value = false;
      });
    });
  }

  RxInt getIndex() => _currentIndex;
}
