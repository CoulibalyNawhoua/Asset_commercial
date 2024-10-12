import 'dart:io';
import 'package:asset_managmant_mobile/pages/compoments/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constantes/constantes.dart';
import '../../controllers/auth.dart';
import '../../controllers/demande.dart';
import '../../controllers/pointDeVente.dart';
import '../../controllers/reparation.dart';
import '../../controllers/territoire.dart';
import '../../controllers/typeIntervention.dart';
import '../compoments/button.dart';
import '../compoments/select_input.dart';

class FormRepairPage extends StatefulWidget {
  const FormRepairPage({super.key});

  @override
  State<FormRepairPage> createState() => _FormRepairPageState();
}

class _FormRepairPageState extends State<FormRepairPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final PointDeVenteController pointDeVenteController = Get.put(PointDeVenteController());
  final TerritoireController territoireController = Get.put(TerritoireController());
  final TypeInterventionController typeInterventionController = Get.put(TypeInterventionController());
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController photoController = TextEditingController();
  final ReparationController reparationController = Get.put(ReparationController());
  final DemandeController demandeController = Get.put(DemandeController());
  String territoireValue = "-1";
  String pointDeVenteValue = "-1";
  String interventionValue = "-1";
  // File? photo;
  List<File> images = []; 

  @override
  void dispose() {
    descriptionController.dispose();
    photoController.dispose();
    typeInterventionController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authenticateController.checkAccessToken();
      territoireController.fetchTerritoire();
      pointDeVenteController.fetchPointDeVente();
      typeInterventionController.fetchTypeIntervention();
    });
  }

  Future<void> _pickImage(TextEditingController controller) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        if (images.length < 2) {
          images.add(File(image.path));
        }
      });
    }
  }

   void saveForm() async {
    
    if (formKey.currentState!.validate()) {
      if (images.length == 2) {
        final description = descriptionController.text;
        bool success = await reparationController.saveReparation(
          territoireId: territoireValue,
          pointDeVenteId: pointDeVenteValue,
          interventionId: interventionValue,
          description: description,
          photos: images,
        );

        reparationController.isLoading.value = false;
        if (success) {
          // Vider le formulaire en cas de succès
          _clearForm();
        }
      } else {
        Get.snackbar("Erreur", "Veuillez ajouter exactement 2 photos.",backgroundColor: Colors.red);
      }
    }
  }


  void _clearForm() {
    setState(() {
      territoireValue = "-1";
      pointDeVenteValue = "-1";
      descriptionController.clear();
      photoController.clear();
      photoController .clear();
      images.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(
        title: "Formulaire de reparation",
        onPressed: (){
          Get.back();
          reparationController.fetchReparation();
          demandeController.fetchTotalAndPercentage();
        }
      ),
     
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: _form(),
          )
        ),
        
      ),
    );
  }

  Widget _form() {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(10),
      borderSide: const BorderSide(color: AppColors.primaryColor)
    );
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return SelectInput(
                value: territoireValue,
                items: [
                  const DropdownMenuItem(
                    value: "-1",
                    child: Text("Sélectionnez le territoire"),
                  ),
                  ...territoireController.territoires.map((territoire) {
                    return DropdownMenuItem(
                      value: territoire.id.toString(),
                      child: Text(territoire.libelle),
                    );
                  }),
                ],
                onChanged: (value) {
                  setState(() {
                    territoireValue = value!;
                  });
                },
                hint: "Sélectionnez le territoire",
                validator: (value) {
                  if (value == "-1") {
                    return "Veuillez sélectionner un territoire";
                  }
                  return null;
                },
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: SelectInput(
                  value: pointDeVenteValue,
                  items: [
                    const DropdownMenuItem(
                      value: "-1",
                      child: Text("Sélectionnez un pdv"),
                    ),
                    ...pointDeVenteController.pointDeVentes.map((pointDeVente) {
                      return DropdownMenuItem(
                        value: pointDeVente.id.toString(),
                        child: Text(
                          pointDeVente.nomPdv,
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      pointDeVenteValue = value!;
                    });
                  },
                  hint: "Sélectionnez un pdv",
                  validator: (value) {
                    if (value == "-1") {
                      return "Veuillez sélectionner un point de vente";
                    }
                    return null;
                  },
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Obx(() {
              return ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
                child: SelectInput(
                  value: interventionValue,
                  items: [
                    const DropdownMenuItem(
                      value: "-1",
                      child: Text("Sélectionnez le type d'intervention"),
                    ),
                    ...typeInterventionController.typeInterventions.map((intervention) {
                      return DropdownMenuItem(
                        value: intervention.id.toString(),
                        child: Text(
                          intervention.libelle,
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      interventionValue = value!;
                    });
                  },
                  hint: "Sélectionnez le type d'intervention",
                  validator: (value) {
                    if (value == "-1") {
                      return "Veuillez sélectionner le type d'intervention";
                    }
                    return null;
                  },
                ),
              );
            }),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: descriptionController,
              maxLines: 3,
              maxLength: 200,
              decoration: InputDecoration(
                hintText: "Description",
                fillColor: Colors.white,
                filled: true,
                focusedBorder: border,
                enabledBorder: border,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Veuillez entrer une description";
                }
                return null;
              },
            ),
          ),
          if (images.length < 2)
            textButom("Ajouter deux photos", () { _pickImage(photoController);}),
          _buildImageGrid(),
          SizedBox(height: 30.0,),
          Obx(() {
            return CButton(
              title: "SOUMETTRE",
              isLoading: reparationController.isLoading.value,
              onPressed: () async {saveForm();},
            );
          }),
        ],
      ),
    );
  }

  Widget _buildImageGrid() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        shrinkWrap: true,
        itemCount: images.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (BuildContext context, int index) {
          return Stack(
            children: [
              Image.file(
                images[index],
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity,
              ),
              Positioned(
                right: 0,
                child: IconButton(
                  icon: const Icon(Icons.cancel, color: Colors.red),
                  onPressed: () {
                    setState(() {
                      images.removeAt(index);
                    });
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  Widget textButom(String title,VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(AppColors.primaryColor), // Couleur du bouton
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
        ),
      ),
      child: Text(title,style: const TextStyle(fontSize: 12.0), )
    );
  }


}
