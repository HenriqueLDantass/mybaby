import 'package:dio/dio.dart';
import 'package:mybabymylife/module/auth/model/auth_model.dart';

class AuthService {
  final Dio dio = Dio();

  AuthService() {
    dio.options.validateStatus = (status) {
      return status! >= 200 || status < 400;
    };
  }

  Future<bool> registerUser(String username, String senha, String email) async {
    const String baseUrl = "http://10.0.2.2:3000/register";
    try {
      final response = await dio.post(baseUrl, data: {
        "username": username,
        "senha": senha,
        "email": email,
      });

      if (response.statusCode == 200) {
        print("Usuário cadastrado com sucesso");
        return true;
      } else if (response.statusCode == 400) {
        print("Usuário já existe");
        return false;
      } else {
        print("Erro ao cadastrar usuário: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      print("Erro ao cadastrar usuário: $e");
      return false;
    }
  }

//alterar username para email tnto aqui quanto na api
  UserModel? userData; // Propriedade para armazenar os dados do usuário

  Future<bool> login(String username, String senha) async {
    try {
      const String baseUrl = "http://10.0.2.2:3000/login";
      final response = await dio.post(baseUrl, data: {
        "username": username,
        "senha": senha,
      });

      if (response.statusCode == 200) {
        print("login efetuado com sucesso");
        // Se o login foi bem-sucedido, atribua os dados do usuário à propriedade userData
        userData = UserModel.fromJson(response.data['user']);
        print(userData!.email);
        print(userData!.userId);

        print(userData!.username);

        print(userData!.senha);

        return true;
      } else {
        print("erro ao efetuar login");
        return false;
      }
    } catch (err) {
      print("erro ao efetuar login: $err");
      return false;
    }
  }
}
