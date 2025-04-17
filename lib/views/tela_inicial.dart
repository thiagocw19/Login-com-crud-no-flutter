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
                  Navigator.pushNamed(context, '/usuario');
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
                  Navigator.pushNamed(context, '/prod');
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
                  Navigator.pushNamed(context, '/cliente');
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
