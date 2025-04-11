import 'package:flutter/material.dart';
import 'package:trabalhofinal/tela_inicial.dart';
import 'login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: 'HOME',
      routes: {
        'HOME': (context) => LoginScreen(),
        'INICIO': (context) => TelaInicial(),
      },
    );
  }
}
