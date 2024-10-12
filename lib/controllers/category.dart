

import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../constantes/api.dart';
import 'package:http/http.dart' as http;

import '../model/Categorie.dart';


class CategoryController extends GetxController {

  final isLoading = false.obs;
  final token = GetStorage().read("access_token");
  
  RxList<Category> categories = <Category>[].obs;

  Future<void> fetchCategory() async {
    
    try {
      isLoading.value = true;
      categories.clear();
      var response = await http.get(Uri.parse(Api.listCategory), headers: {
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      });

      if (response.statusCode == 200) {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        List<dynamic> data = responseBody['data'];
        List<Category> categoriesList = data.map((json) => Category.fromJson(json)).toList();
        
        inspect(categories);
        categories.assignAll(categoriesList);
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
