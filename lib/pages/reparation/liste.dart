import 'package:asset_managmant_mobile/pages/reparation/detail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constantes/constantes.dart';
import '../../controllers/auth.dart';
import '../../controllers/reparation.dart';
import '../../fonctions/fonction.dart';
import '../compoments/reparation_card.dart';
import 'form.dart';

class ListReparation extends StatefulWidget {
  const ListReparation({super.key});

  @override
  State<ListReparation> createState() => _ListReparationState();
}

class _ListReparationState extends State<ListReparation> {

  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final ReparationController reparationController = Get.put(ReparationController());
  final TextEditingController searchController = TextEditingController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authenticateController.checkAccessToken();
      reparationController.fetchReparation();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Liste des Interventions",
          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch("Intervention"),
            const SizedBox(height: 30.0,),
            Expanded(
              child: Obx(() {
                if (reparationController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (reparationController.filteredReparations.isEmpty) {
                  return const Center(child: Text("Aucune intervention trouvée",style: TextStyle(color: Colors.red),));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await reparationController.fetchReparation();
                  },
                  child: ListView.builder(
                    itemCount: reparationController.filteredReparations.length,
                    itemBuilder: (context, index) {
                      var reparation = reparationController.filteredReparations[index];
                      return ReparationItem(
                        title: reparation.dPdv,
                        date: reparation.createdAt,
                        status: reparation.status,
                        onPressed: () {
                          Get.to(DetailReparationPage(uuid: reparation.uuid,));
                        },
                      );
                    },
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSearch(String title) {
    return Row(
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 300),
          width: _isExpanded ? width(context)*0.5 : 50.0,
          decoration: BoxDecoration(
            color: _isExpanded ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(15.0),
            
          ),
          child: Row(
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    _isExpanded = !_isExpanded;
                  });
                },
                
                child: CircleAvatar(
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.search,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 5.0,),
              Expanded(
                child: _isExpanded
                  ? TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Recherche",
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                        reparationController.filterReparations(value);  // Filtrer les reparations
                      },
                      )
                  : Container(),
              ),
            ]
          )
        ),
        Spacer(),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: _isExpanded ? 100.0 : 120.0,
          height: 50.0,
          child: _texButom(title, () {
            Get.to(FormRepairPage());
          }),
        ),
          
      ],
    );
  }

  Widget _texButom(String title,VoidCallback onPressed) {
    return  ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.secondaryColor),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        padding: MaterialStateProperty.all<EdgeInsets>(
          const EdgeInsets.all(5.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.add,
            color: Colors.white,
            size: 16,
          ),
          SizedBox(width: 5.0,),
          Text(title,style: TextStyle(fontSize: 12),),
        ],
      ),
    );
  }
}

