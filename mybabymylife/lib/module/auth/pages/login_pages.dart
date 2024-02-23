import 'package:flutter/material.dart';
import 'package:mybabymylife/module/auth/pages/auth_page.dart';
import 'package:mybabymylife/module/auth/pages/registro_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              "assets/logo.jpg",
              width: 400,
            ),
          ),
          SizedBox(
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const AuthPage()));
              },
              child: Text("Login"),
            ),
          ),
          SizedBox(
            width: 350,
            child: ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (_) => const RegistroPage()));
              },
              child: Text("Registar"),
            ),
          )
        ],
      ),
    );
  }
}
