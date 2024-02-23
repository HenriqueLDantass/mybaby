import 'package:flutter/material.dart';
import 'package:mybabymylife/module/auth/pages/login_pages.dart';
import 'package:mybabymylife/module/auth/stores/login_stores.dart';
import 'package:mybabymylife/module/home/stores/home_store.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<LoginStore>(
          create: (_) => LoginStore(),
        ),
        ChangeNotifierProvider<HomeStore>(
          create: (_) => HomeStore(),
        ),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: LoginPage(),
      ),
    );
  }
}
