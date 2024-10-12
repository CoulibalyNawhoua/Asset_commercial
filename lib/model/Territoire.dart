class Territoire {
  int id;
  String libelle;

  Territoire({
    required this.id,
    required this.libelle,
  });

  factory Territoire.fromJson(Map<String, dynamic> json) => Territoire(
    id: json["id"],
    libelle: json["libelle"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "libelle": libelle,
  };
}
