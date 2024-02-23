import 'package:flutter/material.dart';
import 'package:mybabymylife/module/auth/stores/login_stores.dart';
import 'package:mybabymylife/module/home/pages/home_page.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({Key? key}) : super(key: key);

  Future<void> _showErrorDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro ao Efetuar o login, Usuario ou senha invalidos'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final loginStore = Provider.of<LoginStore>(context);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Login',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: loginStore.usernameControllerLogin,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: loginStore.passwordControllerLogin,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () async {
                final response = await loginStore.login(
                    senha: loginStore.passwordControllerLogin.text,
                    email: loginStore.usernameControllerLogin.text);

                if (response) {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (_) => HomePage()));
                } else {
                  _showErrorDialog(context);
                }
              },
              child: Text('Login'),
            ),
            const SizedBox(height: 10.0),
            TextButton(
              onPressed: () {
                // Implementar a navegação para a tela de registro aqui
              },
              child: Text('Don\'t have an account? Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
