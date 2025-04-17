import 'package:flutter/material.dart';
import 'package:trabalhofinal/views/tela_clientes.dart';
import 'package:trabalhofinal/views/tela_inicial.dart';
import 'package:trabalhofinal/views/tela_produtos.dart';
import 'package:trabalhofinal/views/tela_usuarios.dart';
import 'views/login_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home': (context) => LoginScreen(),
        '/inicio': (context) => TelaInicial(),
        '/prod': (context) => TelaProdutos(),
        '/cliente': (context) => TelaClientes(),
        '/usuario': (context) => TelaUsuarios(),
      },
    );
  }
}
