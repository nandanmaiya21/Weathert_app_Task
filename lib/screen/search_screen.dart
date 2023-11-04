import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_app/controller/global_controller_with_lat_long.dart';
import 'package:weather_app/screen/home_screen.dart';
import 'package:weather_app/screen/search_result_screen.dart';
import 'package:weather_app/utils/custom_colors.dart';
import 'package:geocoding/geocoding.dart';

class SearchScreen extends StatefulWidget {
  static const String route = "/search-screen";
  SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _searchContoller = TextEditingController();

  List<Location>? locations;

  //OnChanges in TextFormField
  void _updateOnChange() {
    if (_searchContoller.text.isEmpty) {
      Get.snackbar('No Text Input', "Empty TextField");
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          centerTitle: true,
          backgroundColor: CustomColors.bgColor,
          leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.black,
            ),
          ),
        ),
      ),
      body: Center(
        child: Form(
          key: _formKey,
          child: Container(
            decoration: BoxDecoration(
                color: CustomColors.cardColor,
                borderRadius: BorderRadius.circular(16)),
            height: 500,
            margin: const EdgeInsets.all(16),
            width: MediaQuery.sizeOf(context).width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Search Place',
                      style:
                          TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 200,
                      alignment: Alignment.center,
                      child: TextFormField(
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        controller: _searchContoller,
                        keyboardType: TextInputType.streetAddress,
                        decoration: InputDecoration(),
                        validator: (value) {
                          if (value == null) {
                            return "Enter the valid city name";
                          }
                          return null;
                        },
                        onChanged: (value) => _updateOnChange(),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 24),
                      child: TextButton(
                          style: ButtonStyle(
                            shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),
                          ),
                          onPressed: () async {
                            List<Location> list =
                                await stringToCoord(_searchContoller.text);

                            if (list.isEmpty) {
                              return;
                            }

                            double latitude = locations![0].latitude;
                            double longitude = locations![0].longitude;

                            GlobalController globalController =
                                GlobalController(
                                    lattitude: RxDouble(latitude),
                                    longitude: RxDouble(latitude));

                            Get.toNamed(SearchResultScreen.route, arguments: [
                              globalController,
                              _searchContoller.text.capitalizeFirst
                            ]);
                          },
                          child: Text(
                            'Search',
                            style: TextStyle(
                                color: CustomColors.iconColor, fontSize: 18),
                          )),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<List<Location>> stringToCoord(String add) async {
    try {
      if (add.isEmpty) {
        Get.snackbar('No vaild Adrerss!', "Entered input is empty or Wrong.");
        throw Exception('Not valid Address!');
      }

      locations = await locationFromAddress(add);
      print(locations);
      return locations!;
    } catch (e) {
      rethrow;
    }
  }
}
