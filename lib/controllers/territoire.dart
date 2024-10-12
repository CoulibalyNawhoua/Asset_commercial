import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

import '../constantes/api.dart';
import '../model/Territoire.dart';

class TerritoireController extends GetxController {
  final isLoading = false.obs;
  final token = GetStorage().read("access_token");
  
  RxList<Territoire> territoires = <Territoire>[].obs;

    Future<void> fetchTerritoire() async {
    try {
      isLoading.value = true;
      territoires.clear();
      var response = await http.get(Uri.parse(Api.listTerritoire), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['data'];
        List<Territoire> territoireList = data.map((json) => Territoire.fromJson(json)).toList();
        territoires.assignAll(territoireList);
      } else {
        isLoading.value = false;

        if (kDebugMode) {
          print("Erreur lors de la récupération des territoires");
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