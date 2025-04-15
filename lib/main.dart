import 'package:flutter/material.dart';
import 'package:trabalhofinal/views/tela_clientes.dart';
import 'package:trabalhofinal/views/tela_inicial.dart';
import 'package:trabalhofinal/views/tela_produtos.dart';
import 'views/login_screen.dart';

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
        'PROD': (context) => TelaProdutos(),
        'CLIENTE': (context) => TelaClientes(),
      },
    );
  }
}
