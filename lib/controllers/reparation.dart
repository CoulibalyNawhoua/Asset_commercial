import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:asset_managmant_mobile/constantes/api.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import '../model/Reparation.dart';

class ReparationController extends GetxController {

  final token = GetStorage().read("access_token");
  final isLoading = false.obs;

  RxList<Reparation> reparations = <Reparation>[].obs;
  Rx<DetailReparation?> reparationDetails = Rx<DetailReparation?>(null);
  RxList<Reparation> filteredReparations = <Reparation>[].obs; // Liste filtrée

  @override
  void onInit() {
    super.onInit();
    fetchReparation();  // Charger les reparations lors de l'initialisation
  }

  void filterReparations(String query) {
    if (query.isEmpty) {
      filteredReparations.assignAll(reparations);  // Réinitialiser la liste filtrée
    } else {
      filteredReparations.assignAll(reparations.where((reparation) =>
        reparation.dPdv.toLowerCase().contains(query.toLowerCase())
      ).toList());
    }
  }


  Future<bool> saveReparation({
    required String territoireId,
    required String pointDeVenteId,
    required String interventionId,
    required String description,
    required List<File> photos,
    
  }) async {

    try {
      isLoading.value = true;

      // var data = {
      //   'territoire_id': territoireId,
      //   'pointdevente_id': pointDeVenteId,
      //   'type_intervention_id': interventionId,
      //   'note_commercial': description,
      //   'photo_materiel': photos,
      // };
      var request = http.MultipartRequest('POST', Uri.parse(Api.saveReparation),);
      request.headers.addAll({
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
        'Content-Type': 'multipart/form-data',
      });
      // Ajouter les champs de texte
      request.fields['territoire_id'] = territoireId;
      request.fields['pointdevente_id'] = pointDeVenteId;
      request.fields['type_intervention_id'] = interventionId;
      request.fields['note_commercial'] = description;

      // Ajouter les fichiers image
      for (var photo in photos) {
        request.files.add(
          await http.MultipartFile.fromPath(
            'photo_materiel[]', // Utilisez un tableau pour envoyer plusieurs fichiers
            photo.path,
            contentType: MediaType('image', 'jpeg'), // ou le type MIME approprié pour vos images
          ),
        );
      }
     
      // Envoyer la requête
      var response = await request.send();
      
      if (response.statusCode == 200) {

        var responseData = await http.Response.fromStream(response);
        var responseBody = json.decode(responseData.body);
        // inspect(responseBody);
        if (responseBody["code"] == 400) {
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
            "Intervention enregistrée avec succès.",
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          return true;
        }
       
      } else {
        isLoading.value = false;
        inspect("Erreur lors de l'enregistrement de l'Intervention'.");
        return false;
      }
    } catch (e) {
      isLoading.value = false;
      inspect("Exception lors de la sauvegarde de l'Intervention': $e");
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchReparation() async {
    try {
      isLoading.value = true;
      reparations.clear();
      var response = await http.get(Uri.parse(Api.listReparation), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['data'];
        List<Reparation> reparationList = data.map((json) => Reparation.fromJson(json)).toList();
        reparations.assignAll(reparationList);
        filteredReparations.assignAll(reparationList); // Appliquer le filtre initial
      } else {
        isLoading.value = false;


        if (kDebugMode) {
          print("Erreur lors de la récupération des reparations");
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

  
  Future<void> fetchDetailReparation(String uuid) async {
    try {
      isLoading.value = true;
      var response = await http.get(
        Uri.parse(Api.reparationDetails(uuid)),
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {

        var responseBody = jsonDecode(response.body);
        var demandeData = responseBody['data'];
        reparationDetails.value = DetailReparation.fromJson(demandeData);

      } else {
        Get.snackbar(
          'Erreur',
          'Erreur lors de la récupération des détails de la réparation.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } finally {
      isLoading.value = false;
    }
  }

}