class Api {
  // static const url = "http://192.168.1.73:8000/api";
  static const url = "https://assets-api.distriforce.shop/api";

  
  static const login = '$url/login-commercial';

  static const listTerritoire = '$url/mob/territoire-list';
  static const listPointDeVente = '$url/distriforce/pointdevente-list';
  static const listCategory = '$url/setting/category-list';

  static const saveDemande = '$url/mob/affectation-demande-create';
  static const listDemande = '$url/mob/affectation-demande-list';
  static String demandeDetails(String uuid) {
    return '$url/mobile-affectation-view/$uuid';
  }


  static const saveReparation = '$url/create-intervention-ccl';
  static const listReparation = '$url/list-interventions-ccl';
  static String reparationDetails(String uuid) {
    return '$url/view-intervention-ccl/$uuid';
  }

  static const totalDemande = '$url/mob/affectation-stats-commercial';


  static const listTypeIntervention = '$url/list-type-interventions';

}




