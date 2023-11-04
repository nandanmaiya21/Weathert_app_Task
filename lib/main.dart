import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:weather_app/screen/auth_screen.dart';
import 'package:weather_app/screen/search_result_screen.dart';
import 'package:weather_app/screen/search_screen.dart';
import '/screen/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      getPages: [
        GetPage(
            name: SearchScreen.route,
            page: () => SearchScreen(),
            transition: Transition.rightToLeft),
        GetPage(
          name: SearchResultScreen.route,
          page: () => const SearchResultScreen(),
          transition: Transition.rightToLeft,
        )
      ],
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          }

          return const AuthScreen();
        },
      ),
      title: "Weather",
      debugShowCheckedModeBanner: false,
    );
  }
}
