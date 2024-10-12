class Demande {
    int id;
    String dPdv;
    DateTime date;
    int status;
    String code;
    String uuid;

    Demande({
        required this.id,
        required this.dPdv,
        required this.date,
        required this.status,
        required this.code,
        required this.uuid,
    });

    factory Demande.fromJson(Map<String, dynamic> json) => Demande(
        id: json["id"],
        dPdv: json["d_pdv"],
        date: DateTime.parse(json["date"]),
        status: json["status"],
        code: json["code"],
        uuid: json["uuid"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "d_pdv": dPdv,
        "date": date.toIso8601String(),
        "status": status,
        "code": code,
        "uuid": uuid,
    };
}

class DetailDemande {
  final int id;
  final String dPdv;
  final DateTime date;
  final int status;
  final String code;
  final String? materielId;
  final int categorieId;
  final String dAddresse;
  final String dContact;
  final String dPdvCategorie;
  final String dPdvManager;
  final String dZone;
  final String dCanal;
  final String dTerritoire;
  final String dSecteur;
  final String dLatitude;
  final String dLongitude;
  final String description;
  final Materiel? materiel;

  DetailDemande({
    required this.id,
    required this.dPdv,
    required this.date,
    required this.status,
    required this.code,
    this.materielId,
    required this.categorieId,
    required this.dAddresse,
    required this.dContact,
    required this.dPdvCategorie,
    required this.dPdvManager,
    required this.dZone,
    required this.dCanal,
    required this.dTerritoire,
    required this.dSecteur,
    required this.dLatitude,
    required this.dLongitude,
    required this.description,
    this.materiel,
  });

  factory DetailDemande.fromJson(Map<String, dynamic> json) {
    return DetailDemande(
      id: json['id'],
      dPdv: json['d_pdv'],
      date: DateTime.parse(json['date']),
      status: json['status'],
      code: json['code'],
      materielId: json['materiel_id'],
      categorieId: json['categorie_id'],
      dAddresse: json['d_addresse'],
      dContact: json['d_contact'],
      dPdvCategorie: json['d_pdv_categorie'],
      dPdvManager: json['d_pdv_manager'],
      dZone: json['d_zone'],
      dCanal: json['d_canal'],
      dTerritoire: json['d_territoire'],
      dSecteur: json['d_secteur'],
      dLatitude: json['d_latitude'],
      dLongitude: json['d_longitude'],
      description: json['description'],
      materiel: json['materiel'] != null ? Materiel.fromJson(json['materiel']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'd_pdv': dPdv,
      'date': date.toIso8601String(),
      'status': status,
      'code': code,
      'materiel_id': materielId,
      'categorie_id': categorieId,
      'd_addresse': dAddresse,
      'd_contact': dContact,
      'd_pdv_categorie': dPdvCategorie,
      'd_pdv_manager': dPdvManager,
      'd_zone': dZone,
      'd_canal': dCanal,
      'd_territoire': dTerritoire,
      'd_secteur': dSecteur,
      'd_latitude': dLatitude,
      'd_longitude': dLongitude,
      'description': description,
      'materiel': materiel?.toJson(),
    };
  }
}

class Materiel {
  final String code;
  final String numSerie;
  final int status;
  final String uuid;
  final String libelle;
  final DateTime dateAcquisition;
  final String image;
  final int categorieId;
  final int marqueId;
  final int modeleId;
  final Categorie categorie;
  final Marque marque;

  Materiel({
    required this.code,
    required this.numSerie,
    required this.status,
    required this.uuid,
    required this.libelle,
    required this.dateAcquisition,
    required this.image,
    required this.categorieId,
    required this.marqueId,
    required this.modeleId,
    required this.categorie,
    required this.marque,
  });

  factory Materiel.fromJson(Map<String, dynamic> json) {
    return Materiel(
      code: json['code'],
      numSerie: json['num_serie'],
      status: json['status'],
      uuid: json['uuid'],
      libelle: json['libelle'],
      dateAcquisition: DateTime.parse(json['date_acquisition']),
      image: json['image'],
      categorieId: json['categorie_id'],
      marqueId: json['marque_id'],
      modeleId: json['modele_id'],
      categorie: Categorie.fromJson(json['categorie']),
      marque: Marque.fromJson(json['marque']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'code': code,
      'num_serie': numSerie,
      'status': status,
      'uuid': uuid,
      'libelle': libelle,
      'date_acquisition': dateAcquisition.toIso8601String(),
      'image': image,
      'categorie_id': categorieId,
      'marque_id': marqueId,
      'modele_id': modeleId,
      'categorie': categorie.toJson(),
      'marque': marque.toJson(),
    };
  }
}

class Categorie {
  final int id;
  final String libelle;

  Categorie({
    required this.id,
    required this.libelle,
  });

  factory Categorie.fromJson(Map<String, dynamic> json) {
    return Categorie(
      id: json['id'],
      libelle: json['libelle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
    };
  }
}

class Marque {
  final int id;
  final String libelle;

  Marque({
    required this.id,
    required this.libelle,
  });

  factory Marque.fromJson(Map<String, dynamic> json) {
    return Marque(
      id: json['id'],
      libelle: json['libelle'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
    };
  }
}

