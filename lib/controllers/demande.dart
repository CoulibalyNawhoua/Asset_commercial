import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';


import '../constantes/api.dart';
import '../model/Demande.dart';

class DemandeController extends GetxController {

  final token = GetStorage().read("access_token");
  final isLoading = false.obs;

  RxList<Demande> demandes = <Demande>[].obs;
  Rx<DetailDemande?> demandeDetails = Rx<DetailDemande?>(null);
  RxMap<String, RxDouble> percentages = <String, RxDouble>{}.obs;
  RxInt termineAffectSum = 0.obs;
  RxInt rejetAffectSum = 0.obs;
  RxInt attenteAffectSum = 0.obs;
  RxInt allAffectSum = 0.obs;
  
  RxList<Demande> filteredDemandes = <Demande>[].obs; // Liste filtrée

  @override
  void onInit() {
    super.onInit();
    fetchDemande();  // Charger les demandes lors de l'initialisation
    fetchTotalAndPercentage();
  }

  void filterDemandes(String query) {
    if (query.isEmpty) {
      filteredDemandes.assignAll(demandes);  // Réinitialiser la liste filtrée
    } else {
      filteredDemandes.assignAll(demandes.where((demande) =>
        demande.dPdv.toLowerCase().contains(query.toLowerCase())
      ).toList());
    }
  }


  Future<bool> saveDemande({
    required String territoireId,
    required String pointDeVenteId,
    required String categorieId,
    required String description,
    required File rectoImage,
    required File versoImage,
  }) async {

    try {
      isLoading.value = true;
      // var data = {
      //   'territoire_id': territoireId,
      //   'pointdevente_id': pointDeVenteId,
      //   'categorie_id': categorieId,
      //   'description': description,
      //   'piece_recto': rectoImage,
      //   'piece_verso': versoImage,
      // };
      var request = http.MultipartRequest('POST', Uri.parse(Api.saveDemande),);
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });
      // Ajouter les champs de texte
      request.fields['territoire_id'] = territoireId;
      request.fields['pointdevente_id'] = pointDeVenteId;
      request.fields['categorie_id'] = categorieId;
      request.fields['description'] = description;

      // Ajouter les fichiers image
      request.files.add(await http.MultipartFile.fromPath(
        'piece_recto',
        rectoImage.path,
        contentType: MediaType('image', 'jpeg'), // ou le type MIME approprié pour vos images
      ));
      request.files.add(await http.MultipartFile.fromPath(
        'piece_verso',
        versoImage.path,
        contentType: MediaType('image', 'jpeg'),
      ));

      // Envoyer la requête
      var response = await request.send();
      
      if (response.statusCode == 200) {
        // isLoading.value = false;

        var responseData = await http.Response.fromStream(response);
        var responseBody = json.decode(responseData.body);
      
        if (responseBody["code"] == 400) {
          // isLoading.value = false;
          Get.snackbar(
            "Echec",
            responseBody["msg"],
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          return false;
        }else{
          isLoading.value = false;
          Get.snackbar(
            "Succès",
            "Demande enregistrée avec succès.",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          return true;
        }
       
      } else {
        isLoading.value = false;
       inspect("Erreur lors de l'enregistrement de la demande.");
       return false;
      }
    } catch (e) {
      isLoading.value = false;
      inspect("Exception lors de la sauvegarde de la demande: $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  
  Future<void> fetchDemande() async {
    try {
      isLoading.value = true;
      demandes.clear();
      var response = await http.get(Uri.parse(Api.listDemande), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['data'];
        List<Demande> demandeList = data.map((json) => Demande.fromJson(json)).toList();
        demandes.assignAll(demandeList);
        filteredDemandes.assignAll(demandeList); // Appliquer le filtre initial
      } else {
        isLoading.value = false;


        if (kDebugMode) {
          print("Erreur lors de la récupération des demandes");
        }

        if (kDebugMode) {
          print(json.decode(response.body));
        }
      }
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  

  Future<void> fetchDetailDemande(String uuid) async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(Api.demandeDetails(uuid)),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {

        var responseBody = jsonDecode(response.body);
        var demandeData = responseBody['data'];
        demandeDetails.value = DetailDemande.fromJson(demandeData);
        // inspect(demandeDetails.value);

      } else {
        print('Erreur lors de la récupération des détails de la demande');
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchTotalAndPercentage() async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(Api.totalDemande),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        
        isLoading.value = false;
        var responseBody = jsonDecode(response.body)["data"];

        termineAffectSum.value = responseBody['termine_affect_sum'];
        rejetAffectSum.value = responseBody['rejet_affect_sum'];
        attenteAffectSum.value = responseBody['attente_affect_sum'];
        allAffectSum.value = responseBody['all_affect_sum'];

        

        if (allAffectSum.value > 0) {
          percentages['termine'] = (termineAffectSum.value / allAffectSum.value).obs;
          percentages['rejet'] = (rejetAffectSum.value / allAffectSum.value).obs;
          percentages['attente'] = (attenteAffectSum.value / allAffectSum.value).obs;
          percentages['total'] = 1.0.obs; // Le pourcentage total est toujours 100% sous forme de fraction
        } else {
          percentages['total'] = 0.0.obs;
          percentages['termine'] = 0.0.obs;
          percentages['rejet'] = 0.0.obs;
          percentages['attente'] = 0.0.obs;
        }


      
      } else {
        isLoading.value = false;
        print('Erreur lors de la récupération des résumés de demande');
      }
    } catch (e) {
      isLoading.value = false;
      if (kDebugMode) {
        print(e.toString());
      } 
    }
  }

  String getPourcentageString(String key) {
    return (percentages[key]! * 100).toStringAsFixed(2) + "%";
  }
}
