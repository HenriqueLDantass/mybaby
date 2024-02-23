import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mybabymylife/firebase_options.dart';
import 'package:mybabymylife/my_app.dart';

void main() async {
  // Certifique-se de inicializar o Flutter antes de executar o aplicativo
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Inicialize o Firebase

  // Execute o aplicativo Flutter
  runApp(MyApp());
}
