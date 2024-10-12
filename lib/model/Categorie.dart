class Category {
    int id;
    String libelle;
    int status;

    Category({
        required this.id,
        required this.libelle,
        required this.status,
    });

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        libelle: json["libelle"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "libelle": libelle,
        "status": status,
    };
}