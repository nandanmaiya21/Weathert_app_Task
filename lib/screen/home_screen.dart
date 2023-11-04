import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:weather_app/widgets/current_weather_widget.dart';
import 'package:weather_app/widgets/hourly_data_widget.dart';
import '../widgets/daily_weather_forcast.dart';
import '/widgets/header_widget.dart';

class HomeScreen extends StatefulWidget {
  static const String route = "/home-screen";

  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //call getProviders
  late final GlobalController globalController;

  @override
  void initState() {
    // TODO: implement initState

    globalController = Get.put(GlobalController(), permanent: true);

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
                      HeaderWidget(globalController: globalController),
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
