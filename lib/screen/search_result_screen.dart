import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/controller/global_controller_with_lat_long.dart';
import 'package:get/get.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';
import '../widgets/daily_weather_forcast.dart';
import '/widgets/header_widget_lat_long.dart';

class SearchResultScreen extends StatefulWidget {
  static const String route = "/home-screen";

  const SearchResultScreen({super.key});

  @override
  State<SearchResultScreen> createState() => _SearchResultScreenState();
}

class _SearchResultScreenState extends State<SearchResultScreen> {
  GlobalController globalController = Get.arguments[0] as GlobalController;
  String name = Get.arguments[1] as String;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => globalController.checkLoading().isTrue
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Center(
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      //Location
                      HeaderWidget(
                          globalController: globalController, name: name),
                      //Current Temp
                      CurrentWeatherWidget(
                        weatherDataCurrent: globalController
                            .getWeatherData()
                            .getCurrentWeather(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      HourlyDataWidget(
                        weatherDataHourly: globalController
                            .getWeatherData()
                            .getHourlyWeather(),
                      ),

                      DailyDataForCast(
                        weatherDataDaily:
                            globalController.getWeatherData().getDailyWether(),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          FirebaseAuth.instance.signOut();
                        },
                        icon: const Icon(Icons.exit_to_app),
                        label: const Text('Logout'),
                      )
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
