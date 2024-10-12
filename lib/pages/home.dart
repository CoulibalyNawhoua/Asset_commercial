import 'package:asset_managmant_mobile/constantes/constantes.dart';
import 'package:asset_managmant_mobile/pages/demande/form.dart';
import 'package:asset_managmant_mobile/pages/reparation/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';

import '../controllers/auth.dart';
import '../controllers/demande.dart';
import '../model/User.dart';
import 'compoments/appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final DemandeController demandeController = Get.put(DemandeController());
  User? user;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authenticateController.checkAccessToken();
      demandeController.fetchTotalAndPercentage();
      getUserData();
    });
  }

  Future<void> getUserData() async {
    var userData = GetStorage().read<Map<String, dynamic>>("user");
    if (userData != null) {
      setState(() {
        user = User.fromJson(userData);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBarHome(name: user != null ? user!.useNom + ' ' + user!.usePrenom : "John Doe"),
        body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 100,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _texButom("Demande",(){Get.to(const FormDemande());},AppColors.primaryColor),
                      _texButom("Reparation",(){Get.to(const FormRepairPage());},AppColors.secondaryColor),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    children: [
                      LayoutBuilder(
                        builder: (context, constraints) {
                          double itemWidth = (constraints.maxWidth - 40) / 2; // 20 spacing on both sides
                          return Obx(() => Wrap(
                            spacing: 20.0,
                            runSpacing: 20.0,
                            children: [
                              _buildGridItem(
                                "Toutes demandes",
                                demandeController.percentages['total'] ?? 0.0.obs,
                                demandeController.allAffectSum,
                                Colors.blue.shade100,
                                itemWidth,
                              ),
                              _buildGridItem(
                                "Demandes acceptées",
                                demandeController.percentages['termine'] ?? 0.0.obs,
                                demandeController.termineAffectSum,
                                Colors.green.shade100,
                                itemWidth,
                              ),
                              _buildGridItem(
                                "Demandes en attentes",
                                demandeController.percentages['attente'] ?? 0.0.obs,
                                demandeController.attenteAffectSum,
                                Colors.yellow.shade100,
                                itemWidth,
                              ),
                              _buildGridItem(
                                "Demandes annulées",
                                demandeController.percentages['rejet'] ?? 0.0.obs,
                                demandeController.rejetAffectSum,
                                Colors.red.shade100,
                                itemWidth,
                              ),
                            ],
                          ));
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _texButom(String title,VoidCallback onPressed,Color color) {
    return  ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(10.0),
        ),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.add,
            color: Colors.white,
          ),
          SizedBox(width: 5.0,),
          Text(title),
        ],
      ),
    );
  }

  Widget _buildGridItem(String title, RxDouble percentage, RxInt total,Color color, double width) {
    return Container(
      width: width,
      height: 200,
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Obx(() => Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 10.0),
          CircularPercentIndicator(
            radius: 50.0,
            lineWidth: 10.0,
            percent: percentage.value,
            animation: true,
            animationDuration: 500,
            center: Text(
              "${(percentage.value * 100).toStringAsFixed(1)}%",
              style: const TextStyle(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            progressColor: Colors.blue,
            circularStrokeCap: CircularStrokeCap.butt,
          ),
          const SizedBox(width: 10.0),
          Text(
            "Total: ${total.value}",
            style: const TextStyle(
              fontSize: 14.0,
            ),
          ),
        ],
      )),
    );
  }
}