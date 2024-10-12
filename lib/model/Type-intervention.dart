class TypeIntervention {
    int id;
    String libelle;
    int status;
    DateTime createdAt;
    DateTime updatedAt;
    int societeId;

    TypeIntervention({
        required this.id,
        required this.libelle,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.societeId,
    });

    factory TypeIntervention.fromJson(Map<String, dynamic> json) => TypeIntervention(
        id: json["id"],
        libelle: json["libelle"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        societeId: json["societe_id"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "societe_id": societeId,
    };
}
