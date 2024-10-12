class PointDeVente {
  final int id;
  final String canal;
  final String zoneCommerciale;
  final String territoire;
  final String secteur;
  final String nomenclatureAGROCI;
  final String isActif;
  final String categoriePdv;
  final String commercial;
  final String nomPdv;
  final String managerPdv;
  final String contact;
  final String address;
  final double latitude;
  final double longitude;
  final DateTime dateCreation;
  final String mobile;
  final String statutFinancier;

  PointDeVente({
    required this.id,
    required this.canal,
    required this.zoneCommerciale,
    required this.territoire,
    required this.secteur,
    required this.nomenclatureAGROCI,
    required this.isActif,
    required this.categoriePdv,
    required this.commercial,
    required this.nomPdv,
    required this.managerPdv,
    required this.contact,
    required this.address,
    required this.latitude,
    required this.longitude,
    required this.dateCreation,
    required this.mobile,
    required this.statutFinancier,
  });

  factory PointDeVente.fromJson(Map<String, dynamic> json) {
    return PointDeVente(
      id: json['Id'],
      canal: json['Canal'],
      zoneCommerciale: json['ZoneCommerciale'],
      territoire: json['Territoire'],
      secteur: json['Secteur'],
      nomenclatureAGROCI: json['NomenclatureAGROCI'],
      isActif: json['IsActif'].trim(),
      categoriePdv: json['CategoriePdv'],
      commercial: json['Commercial'],
      nomPdv: json['NomPdv'],
      managerPdv: json['ManagerPdv'],
      contact: json['Contact'],
      address: json['Address'],
      latitude: double.parse(json['Latitude']),
      longitude: double.parse(json['Longitude']),
      dateCreation: DateTime.parse(json['DateCreation']),
      mobile: json['Mobile'],
      statutFinancier: json['StatutFinancier'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'Id': id,
      'Canal': canal,
      'ZoneCommerciale': zoneCommerciale,
      'Territoire': territoire,
      'Secteur': secteur,
      'NomenclatureAGROCI': nomenclatureAGROCI,
      'IsActif': isActif,
      'CategoriePdv': categoriePdv,
      'Commercial': commercial,
      'NomPdv': nomPdv,
      'ManagerPdv': managerPdv,
      'Contact': contact,
      'Address': address,
      'Latitude': latitude,
      'Longitude': longitude,
      'DateCreation': dateCreation.toIso8601String(),
      'Mobile': mobile,
      'StatutFinancier': statutFinancier,
    };
  }
}
