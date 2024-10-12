import 'dart:io';

import 'package:asset_managmant_mobile/pages/compoments/select_input.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../constantes/constantes.dart';
import '../../controllers/auth.dart';
import '../../controllers/category.dart';
import '../../controllers/demande.dart';
import '../../controllers/pointDeVente.dart';
import '../../controllers/territoire.dart';
import '../compoments/appbar.dart';
import '../compoments/button.dart';

class FormDemande extends StatefulWidget {
  const FormDemande({super.key});

  @override
  State<FormDemande> createState() => _FormDemandeState();
}

class _FormDemandeState extends State<FormDemande> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthenticateController authenticateController = Get.put(AuthenticateController());
  final PointDeVenteController pointDeVenteController = Get.put(PointDeVenteController());
  final CategoryController categorieController = Get.put(CategoryController());
  final TerritoireController territoireController = Get.put(TerritoireController());
  final DemandeController demandeController = Get.put(DemandeController());
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController rectoController = TextEditingController();
  final TextEditingController versoController = TextEditingController();
  String territoireValue = "-1";
  String categorieValue = "-1";
  String pointDeVenteValue = "-1";
  File? rectoImage;
  File? versoImage;

  @override
  void dispose() {
    descriptionController.dispose();
    rectoController.dispose();
    versoController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      authenticateController.checkAccessToken();
      territoireController.fetchTerritoire();
      pointDeVenteController.fetchPointDeVente();
      categorieController.fetchCategory();
    });
  }

  Future<void> _pickImage(TextEditingController controller, String type) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      setState(() {
        if (type == "recto") {
          rectoImage = File(image.path);
        } else {
          versoImage = File(image.path);
        }
      });
      controller.text = image.path;
    }
  }

void saveForm() async {
  if (_formKey.currentState!.validate()) {
    if (rectoImage == null && versoImage == null) {
      Get.snackbar(
        "Erreur",
        "Veuillez ajouter une photo.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return;
    }

    // Assurez-vous que les images ne sont pas nulles avant d'essayer de les utiliser
    if (rectoImage != null && versoImage != null) {
      final description = descriptionController.text;
      bool success = await demandeController.saveDemande(
        territoireId: territoireValue,
        pointDeVenteId: pointDeVenteValue,
        categorieId: categorieValue,
        description: description,
        rectoImage: rectoImage!,
        versoImage: versoImage!,
      );
      demandeController.isLoading.value = false;
      if (success) {
        // Vider le formulaire en cas de succès
        _clearForm();
      }
     
    } else {
      // Gérez le cas où les images sont nulles
      Get.snackbar(
        "Erreur",
        "Veuillez ajouter les deux photos.",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
    
  }
}

  void _clearForm() {
    setState(() {
      territoireValue = "-1";
      categorieValue = "-1";
      pointDeVenteValue = "-1";
      descriptionController.clear();
      rectoController.clear();
      versoController.clear();
      rectoImage = null;
      versoImage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CAppBar(
        title: "Formulaire de demande",
        onPressed: () {
          Get.back();
          demandeController.fetchDemande();
          demandeController.fetchTotalAndPercentage();
        },
        
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
      key: _formKey,
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
                  value: categorieValue,
                  items: [
                    const DropdownMenuItem(
                      value: "-1",
                      child: Text("Sélectionnez une catégorie"),
                    ),
                    ...categorieController.categories.map((categorie) {
                      return DropdownMenuItem(
                        value: categorie.id.toString(),
                        child: Text(
                          categorie.libelle,
                        ),
                      );
                    }),
                  ],
                  onChanged: (value) {
                    setState(() {
                      categorieValue = value!;
                    });
                  },
                  hint: "Sélectionnez une catégorie",
                  validator: (value) {
                      if (value == "-1") {
                        return "Veuillez sélectionner une catégorie";
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(rectoController, "recto");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: rectoImage != null
                          ? Image.file(
                              rectoImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt),
                                Text("Prendre une photo recto"),
                              ],
                            ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _pickImage(versoController, "verso");
                    },
                    child: Container(
                      padding: const EdgeInsets.all(5.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: AppColors.primaryColor),
                      ),
                      child: versoImage != null
                          ? Image.file(
                              versoImage!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.camera_alt),
                                Text("Prendre une photo verso"),
                              ],
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 50),
          Obx(() {
            return CButton(
              title: "SOUMETTRE",
              isLoading: demandeController.isLoading.value,
              onPressed: () async {saveForm();},
            );
          }),
          // CButton(
          //   title: "ENREGISTRER", 
          //   isLoading: demandeController.isLoading.value,
          //   onPressed: () async {saveForm();},
          // )
        ],
      ),
       
    );
  }
}
