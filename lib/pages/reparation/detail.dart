import 'package:asset_managmant_mobile/pages/compoments/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constantes/constantes.dart';
import '../../controllers/auth.dart';
import '../../controllers/reparation.dart';
import '../../fonctions/fonction.dart';

class DetailReparationPage extends StatefulWidget {
  final String uuid;
  const DetailReparationPage({super.key, required this.uuid});

  @override
  State<DetailReparationPage> createState() => _DetailReparationPageState();
}

class _DetailReparationPageState extends State<DetailReparationPage> {

  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final ReparationController reparationController = Get.put(ReparationController());

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        authenticateController.checkAccessToken();
        reparationController.fetchDetailReparation(widget.uuid);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(
        title: "Détail de la réparation", 
        onPressed: (){
          Get.back();
          reparationController.fetchReparation();
        }
      ),
      body: Obx(() {
        if (reparationController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final reparation = reparationController.reparationDetails.value;
        if (reparation == null) {
          return const Center(child: Text("Aucune donnée trouvée",style: TextStyle(color: Colors.red),));
        }

        return Padding(
          padding: EdgeInsets.symmetric(vertical: height(context) * 0.03, horizontal: width(context) * 0.05),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Détail de l'intervention de la réparation",style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20.0,),
                      _buildRowItemStatus("Status:", reparation.status),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Territoire:",reparation.dTerritoire),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Catégorie de PDV:",reparation.dPdvCategorie),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Nom du PDV:",reparation.dPdv),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Contact:",reparation.dContact),
                      const SizedBox(height: 10.0,),
                     _buildRowItem("Manager:",reparation.dPdvManager),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Adresse:",reparation.dAddresse),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Canal:",reparation.dCanal),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Zone:",reparation.dZone),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Territoire:",reparation.dTerritoire),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Secteur:", reparation.dSecteur),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Position Géographique:","${double.parse(reparation.dLatitude).toStringAsFixed(2)}, ${double.parse(reparation.dLongitude).toStringAsFixed(2)}"),
                      
                      const SizedBox(height: 10.0,),
                      const Text("Description:",style: TextStyle(color: Colors.grey, fontSize: 12),),
                      Text(reparation.noteCommercial),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
  Widget _buildRowItem(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(color: Colors.grey, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 12),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  Widget _buildRowItemStatus(String title, int value) {
    String statusText;
    Color statusColor;

    switch (value) {
      case 0:
        statusText = "Inactif";
        statusColor = Colors.yellow.shade900;
        break;
      case 1:
        statusText = "En cours ";
        statusColor = Colors.yellow.shade900;
        break;
      case 2:
        statusText = "Annulée";
        statusColor = Colors.red;
        break;
      case 3:
        statusText = "Terminée";
        statusColor = Colors.green;
        break;
      default:
        statusText = "intervention supprimer";
        statusColor = Colors.red;
        break;
    }
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.grey),
        ),
        Text(
          statusText,
          style: TextStyle(color: statusColor),
        )
      ],
    );
  }
}