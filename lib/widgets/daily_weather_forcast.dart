import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/model/weather/weather_daily_data.dart';
import 'package:weather_app/utils/custom_colors.dart';

class DailyDataForCast extends StatelessWidget {
  final WeatherDataDaily weatherDataDaily;
  const DailyDataForCast({
    Key? key,
    required this.weatherDataDaily,
  }) : super(key: key);

  String getDay(final day) {
    DateTime time = DateTime.fromMillisecondsSinceEpoch(day * 1000);
    final temp = DateFormat('EEE').format(time);

    return temp;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 400,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: CustomColors.dividerLine.withAlpha(150),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.topLeft,
            margin: const EdgeInsets.only(bottom: 20),
            child: const Text(
              "Next Days",
              style: TextStyle(
                color: CustomColors.textColorBlack,
                fontSize: 17,
              ),
            ),
          ),
          dailyList(),
        ],
      ),
    );
  }

  Widget dailyList() {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemBuilder: (ctx, index) {
          return Column(
            children: [
              Container(
                height: 60,
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(
                      child: Text(
                        getDay(weatherDataDaily.daily[index].dt),
                        style: const TextStyle(
                            color: CustomColors.textColorBlack, fontSize: 13),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                      width: 30,
                      child: Image.asset(
                        "assets/weather/${weatherDataDaily.daily[index].weather![0].icon}.png",
                      ),
                    ),
                    Text(
                      "${weatherDataDaily.daily[index].temp!.min}°/${weatherDataDaily.daily[index].temp!.max}°",
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 2,
                thickness: 2,
                indent: 10,
                endIndent: 10,
                color: CustomColors.dividerLine,
              ),
            ],
          );
        },
        itemCount: weatherDataDaily.daily.length > 7
            ? 7
            : weatherDataDaily.daily.length,
      ),
    );
  }
}
