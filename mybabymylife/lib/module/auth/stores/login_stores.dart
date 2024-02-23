import 'package:flutter/material.dart';
import 'package:mybabymylife/module/auth/model/auth_model.dart';
import 'package:mybabymylife/module/auth/services/auth_services.dart';

class LoginStore extends ChangeNotifier {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final TextEditingController usernameControllerLogin = TextEditingController();
  final TextEditingController passwordControllerLogin = TextEditingController();
  final TextEditingController emailControllerLogin = TextEditingController();

  final AuthService authservice = AuthService();

  List<UserModel?> userList = [];

  Future<bool> register(
      {required String username,
      required String senha,
      required String email}) async {
    if (username.isNotEmpty && senha.isNotEmpty && email.isNotEmpty) {
      return await authservice.registerUser(username, senha, email);
    } else {
      return false;
    }
  }

  UserModel? loggedInUser;

  Future<bool> login({required String senha, required String email}) async {
    if (email.isNotEmpty && senha.isNotEmpty) {
      final bool loggedIn = await authservice.login(email, senha);

      if (loggedIn) {
        // Se o login foi bem-sucedido, atribua os dados do usuário à variável loggedInUser
        final userData = authservice.userData;
        if (userData != null) {
          loggedInUser = userData;
          notifyListeners(); // Notifique os ouvintes sobre a mudança nos dados do usuário
          return true;
        }
      }
    }
    return false;
  }
}
