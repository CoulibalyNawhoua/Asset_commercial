class User {
  int id;
  String useNom;
  String email;
  String usePrenom;
  String phone;
  dynamic phoneTwo;
  String useLieuNaissance;
  DateTime useDateNaissance;
  int societeId;
  String sexe;
  dynamic roleId;
  dynamic emailVerifiedAt;
  int isActive;
  DateTime createdAt;
  DateTime updatedAt;
  String uuid;

  User({
    required this.id,
    required this.useNom,
    required this.email,
    required this.usePrenom,
    required this.phone,
    required this.phoneTwo,
    required this.useLieuNaissance,
    required this.useDateNaissance,
    required this.societeId,
    required this.sexe,
    required this.roleId,
    required this.emailVerifiedAt,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.uuid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    useNom: json["use_nom"],
    email: json["email"],
    usePrenom: json["use_prenom"],
    phone: json["phone"],
    phoneTwo: json["phone_two"],
    useLieuNaissance: json["use_lieu_naissance"],
    useDateNaissance: DateTime.parse(json["use_date_naissance"]),
    societeId: json["societe_id"],
    sexe: json["sexe"],
    roleId: json["role_id"],
    emailVerifiedAt: json["email_verified_at"],
    isActive: json["is_active"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "use_nom": useNom,
    "email": email,
    "use_prenom": usePrenom,
    "phone": phone,
    "phone_two": phoneTwo,
    "use_lieu_naissance": useLieuNaissance,
    "use_date_naissance": useDateNaissance.toIso8601String(),
    "societe_id": societeId,
    "sexe": sexe,
    "role_id": roleId,
    "email_verified_at": emailVerifiedAt,
    "is_active": isActive,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "uuid": uuid,
  };
}
class Societe {
  int id;
  String name;
  String adresse;
  String tel;

  Societe({
    required this.id,
    required this.name,
    required this.adresse,
    required this.tel,
  });

  factory Societe.fromJson(Map<String, dynamic> json) => Societe(
    id: json["id"],
    name: json["name"],
    adresse: json["adresse"],
    tel: json["tel"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "adresse": adresse,
    "tel": tel,
  };
}
class UserResponse {
  String accessToken;
  String tokenType;
  User user;
  Societe societe;

  UserResponse({
    required this.accessToken,
    required this.tokenType,
    required this.user,
    required this.societe,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
    accessToken: json["access_token"],
    tokenType: json["token_type"],
    user: User.fromJson(json["user"]),
    societe: Societe.fromJson(json["societe"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "token_type": tokenType,
    "user": user.toJson(),
    "societe": societe.toJson(),
  };
}