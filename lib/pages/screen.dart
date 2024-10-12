import 'package:asset_managmant_mobile/constantes/constantes.dart';
import 'package:flutter/material.dart';

import 'auth/login.dart';
import 'compoments/chargement_text_animation.dart';

class ChargementPage extends StatefulWidget {
  const ChargementPage({super.key});

  @override
  State<ChargementPage> createState() => _ChargementPageState();
}

class _ChargementPageState extends State<ChargementPage> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }
  
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
           Image(image: AssetImage("assets/images/logo.png")),
            SizedBox(height: 50,),
           ChargementTextAnimation(),
          ],
        ),
      ),
    );
  }
}