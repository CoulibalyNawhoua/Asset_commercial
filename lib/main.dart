import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'pages/screen.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  runApp(const MyApp());
  await GetStorage.init();
  initializeDateFormatting("fr_FR", null);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return  GetMaterialApp(
      // theme: ThemeData(
      //   useMaterial3: false,
      //   appBarTheme: AppBarTheme(
      //     backgroundColor: Colors.white,
      //     elevation: 0,
      //     // iconTheme: IconThemeData(color: AppColors.primaryColor),
      //     titleTextStyle: TextStyle(
      //       color: AppColors.primaryColor,
      //       fontWeight: FontWeight.bold,
      //       fontSize: 20, // ajustez la taille de la police si nécessaire
      //     ),
      //     systemOverlayStyle: SystemUiOverlayStyle(
      //       statusBarIconBrightness: Brightness.dark,
      //       statusBarBrightness: Brightness.light, // Pour Android
      //       statusBarColor: Colors.white, // Couleur de la barre de statut pour Android
      //     ),
      //   ),
      // ),
      debugShowCheckedModeBanner: false,
      home: ChargementPage(),
    );
  }
}


