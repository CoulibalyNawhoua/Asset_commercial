import 'package:asset_managmant_mobile/pages/demande/liste.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../constantes/constantes.dart';
import '../../controllers/auth.dart';
import '../../fonctions/fonction.dart';
import '../home.dart';
import '../reparation/liste.dart';

class BaseApp extends StatefulWidget {
  const BaseApp({super.key});

  @override
  State<BaseApp> createState() => _BaseAppState();
}

class _BaseAppState extends State<BaseApp> {
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authenticateController.checkAccessToken();
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: getFooter(),
      body: getBody(),
    );
  }
  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: const [
        HomePage(),
        ListDemande(),
        ListReparation(),
      ],
    );
  }


  Widget getFooter() {
    List<Map<String, dynamic>> items = [
      {
        "icon": FontAwesomeIcons.house,
        "text": "Accueil"
      },
      {
        "icon": FontAwesomeIcons.clipboard,
        "text": "Demandes"
      },
      {
        "icon": FontAwesomeIcons.wrench,
        "text": "Réparations"
      },
       
    ];
    return Container(
      width: width(context),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) {
            return InkWell(
              onTap: () {
                setState(() {
                  pageIndex = index;
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      items[index]["icon"],
                      size: 25,
                      color: pageIndex == index
                        ? AppColors.secondaryColor //  couleur(quand le bouton est activé)
                        : AppColors.primaryColor,
                    ),
                    Text(
                      items[index]["text"],
                      style: TextStyle(
                        fontSize: 14,
                        color: pageIndex == index
                          ? AppColors.secondaryColor  // couleur(quand le bouton est activé)
                          : AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }


}