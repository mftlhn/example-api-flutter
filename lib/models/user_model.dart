class UserModel {
  int? id;
  String? token, name, email;
  DateTime? createdAt, updatedAt;

  UserModel(
      {this.id,
      this.token,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    token = json['token'];
    name = json['name'];
    email = json['emaail'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'email': email,
      'createdAt': createdAt,
      'updatedAt': updatedAt
    };
  }
}
