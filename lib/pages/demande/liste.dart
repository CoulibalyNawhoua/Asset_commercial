import 'package:asset_managmant_mobile/pages/demande/detail.dart';
import 'package:asset_managmant_mobile/pages/demande/form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constantes/constantes.dart';
import '../../controllers/auth.dart';
import '../../controllers/demande.dart';
import '../../fonctions/fonction.dart';
import '../compoments/demande_card.dart';

class ListDemande extends StatefulWidget {
  const ListDemande({super.key});

  @override
  State<ListDemande> createState() => _ListDemandeState();
}

class _ListDemandeState extends State<ListDemande> {
  
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final DemandeController demandeController = Get.put(DemandeController());
  final TextEditingController searchController = TextEditingController();
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authenticateController.checkAccessToken();
      demandeController.fetchDemande();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "Liste des demandes ",
          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
     
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearch("Demande"),
            // _texButom("Faire une demande",(){Get.to(const FormDemande());}),
            const SizedBox(height: 30.0,),
            Expanded(
              child: Obx(() {
                if (demandeController.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (demandeController.filteredDemandes.isEmpty) {
                  return const Center(child: Text("Aucune demande trouvée",style: TextStyle(color: Colors.red),));
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    await demandeController.fetchDemande();
                  },
                  child: ListView.builder(
                    itemCount: demandeController.filteredDemandes.length,
                    itemBuilder: (context, index) {
                      var demande = demandeController.filteredDemandes[index];
                      return DemandeItem(
                        title: demande.dPdv,
                        date: demande.date,
                        status: demande.status,
                        onPressed: () {
                          Get.to(DetailDemandePage(uuid: demande.uuid));
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

  Widget _texButom(String title,VoidCallback onPressed) {
    return  ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor),
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

    Widget _buildSearch( String title) {
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
                        demandeController.filterDemandes(value);  // Filtrer les demandes
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
            Get.to(FormDemande());
          }),
        ),
          
      ],
    );
  }
}