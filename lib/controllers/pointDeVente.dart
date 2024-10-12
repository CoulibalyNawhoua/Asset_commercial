import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../constantes/api.dart';
import '../model/PointDeVente.dart';

class PointDeVenteController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read("access_token");
  
  RxList<PointDeVente> pointDeVentes = <PointDeVente>[].obs;

    Future<void> fetchPointDeVente() async {
    try {
      isLoading.value = true;
      pointDeVentes.clear();
      var response = await http.get(Uri.parse(Api.listPointDeVente), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody;
        List<PointDeVente> pointDeVenteList = data.map((json) => PointDeVente.fromJson(json)).toList();
        pointDeVentes.assignAll(pointDeVenteList);
      } else {
        isLoading.value = false;

        if (kDebugMode) {
          print("Erreur lors de la récupération des transactions");
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
  
}