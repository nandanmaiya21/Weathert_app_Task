import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:weather_app/screen/search_screen.dart';
import 'package:weather_app/utils/custom_colors.dart';
import '/controller/global_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HeaderWidget extends StatefulWidget {
  final GlobalController globalController;
  HeaderWidget({super.key, required this.globalController});

  @override
  State<HeaderWidget> createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  String city = '';
  DateTime date = DateTime.now();

  @override
  void initState() {
    getAddress(widget.globalController.getLattitude().value,
        widget.globalController.getLongitude().value);
    super.initState();
  }

  getAddress(double lat, double lon) async {
    List<Placemark> placemark = await placemarkFromCoordinates(lat, lon);
    Placemark place = placemark[0];

    setState(() {
      city = place.locality!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 20, right: 20),
              alignment: Alignment.topLeft,
              child: Text(
                city,
                style: const TextStyle(fontSize: 35, height: 2),
              ),
            ),
            Container(
                margin: const EdgeInsets.only(top: 8, right: 16),
                child: IconButton(
                    onPressed: () => Get.toNamed(SearchScreen.route),
                    icon: Icon(
                      Icons.search,
                      color: CustomColors.iconColor,
                      size: 35,
                    )))
          ],
        ),
        Container(
          margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
          alignment: Alignment.topLeft,
          child: Text(
            DateFormat('yMMMd').format(date),
            style:
                TextStyle(fontSize: 15, color: Colors.grey[700], height: 1.5),
          ),
        ),
      ],
    );
  }
}
