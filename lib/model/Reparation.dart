class Reparation {
 int id;
    dynamic dateCloture;
    int societeId;
    int pointdeventeId;
    dynamic materielId;
    int status;
    int deleted;
    String uuid;
    int addBy;
    dynamic editBy;
    DateTime createdAt;
    DateTime updatedAt;
    String code;
    String photoMateriel;
    String noteCommercial;
    int territoireId;
    String dCanal;
    String dZone;
    String dTerritoire;
    String dSecteur;
    String dPdvCategorie;
    String dPdv;
    String dContact;
    String dMobile;
    String dAddresse;
    String dLatitude;
    String dLongitude;
    String dPdvManager;

  Reparation({
    required this.id,
    required this.dateCloture,
    required this.societeId,
    required this.pointdeventeId,
    required this.materielId,
    required this.status,
    required this.deleted,
    required this.uuid,
    required this.addBy,
    required this.editBy,
    required this.createdAt,
    required this.updatedAt,
    required this.code,
    required this.photoMateriel,
    required this.noteCommercial,
    required this.territoireId,
    required this.dCanal,
    required this.dZone,
    required this.dTerritoire,
    required this.dSecteur,
    required this.dPdvCategorie,
    required this.dPdv,
    required this.dContact,
    required this.dMobile,
    required this.dAddresse,
    required this.dLatitude,
    required this.dLongitude,
    required this.dPdvManager,
  });

  factory Reparation.fromJson(Map<String, dynamic> json) => Reparation(
    id: json["id"],
    dateCloture: json["date_cloture"],
    societeId: json["societe_id"],
    pointdeventeId: json["pointdevente_id"],
    materielId: json["materiel_id"],
    status: json["status"],
    deleted: json["deleted"],
    uuid: json["uuid"],
    addBy: json["add_by"],
    editBy: json["edit_by"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    code: json["code"],
    photoMateriel: json["photo_materiel"],
    noteCommercial: json["note_commercial"],
    territoireId: json["territoire_id"],
    dCanal: json["d_canal"],
    dZone: json["d_zone"],
    dTerritoire: json["d_territoire"],
    dSecteur: json["d_secteur"],
    dPdvCategorie: json["d_pdv_categorie"],
    dPdv: json["d_pdv"],
    dContact: json["d_contact"],
    dMobile: json["d_mobile"],
    dAddresse: json["d_addresse"],
    dLatitude: json["d_latitude"],
    dLongitude: json["d_longitude"],
    dPdvManager: json["d_pdv_manager"],
  );

  Map<String, dynamic> toJson() => {
   "id": id,
    "date_cloture": dateCloture,
    "societe_id": societeId,
    "pointdevente_id": pointdeventeId,
    "materiel_id": materielId,
    "status": status,
    "deleted": deleted,
    "uuid": uuid,
    "add_by": addBy,
    "edit_by": editBy,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "code": code,
    "photo_materiel": photoMateriel,
    "note_commercial": noteCommercial,
    "territoire_id": territoireId,
    "d_canal": dCanal,
    "d_zone": dZone,
    "d_territoire": dTerritoire,
    "d_secteur": dSecteur,
    "d_pdv_categorie": dPdvCategorie,
    "d_pdv": dPdv,
    "d_contact": dContact,
    "d_mobile": dMobile,
    "d_addresse": dAddresse,
    "d_latitude": dLatitude,
    "d_longitude": dLongitude,
    "d_pdv_manager": dPdvManager,
  };
}
class DetailReparation {
  int id;
  String noteCommercial;
  String photoMateriel;
  int status;
  String dPdv;
  String dAddresse;
  String dContact;
  String dPdvCategorie;
  String dPdvManager;
  String dZone;
  String dCanal;
  String dTerritoire;
  String dSecteur;
  String dLatitude;
  String dLongitude;

  DetailReparation({
    required this.id,
    required this.noteCommercial,
    required this.photoMateriel,
    required this.status,
    required this.dPdv,
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
  });

  factory DetailReparation.fromJson(Map<String, dynamic> json) => DetailReparation(
    id: json["id"],
    noteCommercial: json["note_commercial"],
    photoMateriel: json["photo_materiel"],
    status: json["status"],
    dPdv: json["d_pdv"],
    dAddresse: json["d_addresse"],
    dContact: json["d_contact"],
    dPdvCategorie: json["d_pdv_categorie"],
    dPdvManager: json["d_pdv_manager"],
    dZone: json["d_zone"],
    dCanal: json["d_canal"],
    dTerritoire: json["d_territoire"],
    dSecteur: json["d_secteur"],
    dLatitude: json["d_latitude"],
    dLongitude: json["d_longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "note_commercial": noteCommercial,
    "photo_materiel": photoMateriel,
    "status": status,
    "d_pdv": dPdv,
    "d_addresse": dAddresse,
    "d_contact": dContact,
    "d_pdv_categorie": dPdvCategorie,
    "d_pdv_manager": dPdvManager,
    "d_zone": dZone,
    "d_canal": dCanal,
    "d_territoire": dTerritoire,
    "d_secteur": dSecteur,
    "d_latitude": dLatitude,
    "d_longitude": dLongitude,
  };
}
