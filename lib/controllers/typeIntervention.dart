

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constantes/api.dart';
import 'package:http/http.dart' as http;

import '../model/Type-intervention.dart';


class TypeInterventionController extends GetxController {

  final isLoading = false.obs;
  final token = GetStorage().read("access_token");
  
  RxList<TypeIntervention> typeInterventions = <TypeIntervention>[].obs;

  Future<void> fetchTypeIntervention() async {
    
    try {
      isLoading.value = true;
      typeInterventions.clear();
      var response = await http.get(Uri.parse(Api.listTypeIntervention), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['data'];
        List<TypeIntervention> typeInterventionList = data.map((json) => TypeIntervention.fromJson(json)).toList();
        
        typeInterventions.assignAll(typeInterventionList);
      } else {

        isLoading.value = false;
        inspect(json.decode(response.body));


      }
    } catch (e) {
      isLoading.value = false;
     
    } finally {
      isLoading.value = false;
    }
  }
}
