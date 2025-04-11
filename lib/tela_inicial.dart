import 'package:flutter/material.dart';

class TelaInicial extends StatelessWidget {
  const TelaInicial({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text('Tela Inicial')),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  // adicionar a rota para cadastro de usuário (em andamento)
                },
                child: Text('Cadastrar Usuário'),
                color: Colors.amber,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  // adicionar a rota para cadastro de Produto (em andamento)
                },
                child: Text('Cadastrar Produto'),
                color: Colors.amber,
                textColor: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: MaterialButton(
                minWidth: double.infinity,
                onPressed: () {
                  // adicionar a rota para cadastro de cliente (em andamento)
                },
                child: Text('Cadastrar Cliente'),
                color: Colors.amber,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
