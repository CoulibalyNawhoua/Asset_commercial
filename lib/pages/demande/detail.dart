import 'package:asset_managmant_mobile/constantes/constantes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../controllers/auth.dart';
import '../../controllers/demande.dart';
import '../../fonctions/fonction.dart';

class DetailDemandePage extends StatefulWidget {
  final String uuid;
  const DetailDemandePage({super.key, required this.uuid});

  @override
  State<DetailDemandePage> createState() => _DetailDemandePageState();
}

class _DetailDemandePageState extends State<DetailDemandePage> {
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final DemandeController demandeController = Get.put(DemandeController());

  @override
  void initState() {
    super.initState();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        authenticateController.checkAccessToken();
        demandeController.fetchDetailDemande(widget.uuid);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Text(
          "Détail de la demande",
          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: AppColors.primaryColor,),
          onPressed: () {
            Get.back();
            demandeController.fetchDemande();
          },
        ),
      ),
      body: Obx(() {
        if (demandeController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final demande = demandeController.demandeDetails.value;
        if (demande == null) {
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
                      const Text("Détail de la demande d'affection",style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20.0,),
                      
                      _buildRowItem("Code:", demande.code),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Date de création:", DateFormat('dd MMMM yyyy: HH\'h\'mm','fr_FR').format(demande.date),),
                      const SizedBox(height: 10.0,),
                      _buildRowItemStatus("Status:", demande.status.toString()),
                      const SizedBox(height: 10.0,),
                      const Text("Description:",style: TextStyle(color: Colors.grey, fontSize: 12),),
                      Text(demande.description),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(10.0),
                  margin: const EdgeInsets.only(top: 30.0),
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10.0),),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Information du point de vente",style: TextStyle(fontWeight: FontWeight.bold),),
                      const SizedBox(height: 20.0,),
                      _buildRowItem("Nom du PDV:",demande.dPdv),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Manager:",demande.dPdvManager),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Contact:",demande.dContact),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Catégorie de PDV:",demande.dPdvCategorie),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Adresse:",demande.dAddresse),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Canal:",demande.dCanal),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Zone:",demande.dZone),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Territoire:",demande.dTerritoire),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Secteur:", demande.dSecteur),
                      const SizedBox(height: 10.0,),
                      _buildRowItem("Position Géographique:","${double.parse(demande.dLatitude).toStringAsFixed(2)}, ${double.parse(demande.dLongitude).toStringAsFixed(2)}"),
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

  Row _buildRowItemStatus(String title, String value) {
    String statusText;
    Color statusColor;

    switch (value) {
      case '5':
        statusText = "Terminée";
        statusColor = Colors.green;
        break;
      case '6':
        statusText = "Rejetée";
        statusColor = Colors.red;
        break;
      default:
        statusText = "En cours";
        statusColor = Colors.yellow.shade900;
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


  
}