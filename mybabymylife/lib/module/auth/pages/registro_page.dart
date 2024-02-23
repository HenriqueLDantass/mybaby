import 'package:flutter/material.dart';
import 'package:mybabymylife/module/auth/pages/auth_page.dart';
import 'package:mybabymylife/module/auth/pages/login_pages.dart';
import 'package:mybabymylife/module/auth/stores/login_stores.dart';
import 'package:provider/provider.dart';

class RegistroPage extends StatelessWidget {
  const RegistroPage({
    Key? key,
  }) : super(key: key);

  Future<void> _showSuccessDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sucesso'),
          content: Text('Usuário registrado com sucesso.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const AuthPage()));
              },
              child: Text('Fazer login'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showErrorDialog(BuildContext context, String message) async {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Erro'),
          content: Text(message),
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
    final GlobalKey<FormState> key = GlobalKey<FormState>();
    final loginStore = Provider.of<LoginStore>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Registro',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: key,
          child: ListView(children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                TextFormField(
                  controller: loginStore.usernameController,
                  decoration: const InputDecoration(
                    labelText: 'Nome',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preencha os campos";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                    controller: loginStore.emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Preencha os campos";
                      }
                      return null;
                    }),
                const SizedBox(height: 20),
                TextFormField(
                  controller: loginStore.passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Senha',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Preencha os campos";
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if (key.currentState!.validate()) {
                      final registerResult = await loginStore.register(
                          username: loginStore.usernameController.text,
                          senha: loginStore.passwordController.text,
                          email: loginStore.emailController.text);

                      if (registerResult) {
                        _showSuccessDialog(context);
                      } else {
                        _showErrorDialog(context, "Usuário já existe");
                      }
                    }
                  },
                  child: Text("Registrar"),
                ),
                const SizedBox(height: 10),
                TextButton(
                  onPressed: () {},
                  child: const Text("Já tem uma conta? Faça login"),
                )
              ],
            ),
          ]),
        ),
      ),
    );
  }
}
