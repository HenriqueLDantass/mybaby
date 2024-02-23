class UserModel {
  late int userId;
  late String username;
  late String email;
  late String senha;

  UserModel({
    required this.userId,
    required this.username,
    required this.email,
    required this.senha,
  });

  // Método para criar uma instância de UserModel a partir de um mapa (JSON)
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'] ?? 0,
      username: json['username'] ?? "",
      email: json['email'] ?? "",
      senha: json['senha'] ?? "",
    );
  }
}
