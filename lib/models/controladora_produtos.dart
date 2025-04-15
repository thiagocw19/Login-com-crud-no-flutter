import 'package:flutter/material.dart';

class Produtos {
  int id;
  String nome;
  String unidade;
  int estoque;
  double preco;
  int status;

  Produtos({
    required this.id,
    required this.nome,
    required this.unidade,
    required this.estoque,
    required this.preco,
    required this.status,
  });
}

class Controladora {
  final List<Produtos> lista = [
    Produtos(
      id: 1,
      nome: 'carne',
      unidade: '1 kg',
      estoque: 1,
      preco: 40,
      status: 1,
    ),
  ];

  List<Produtos> get produtos => lista;

  void excluirProduto(int idParaExcluir) {
    lista.removeWhere((produto) => produto.id == idParaExcluir);
  }

  void salvarProduto(Produtos p) {
    if (p.id == 0) {
      p.id =
          lista.isEmpty
              ? 1
              : lista.reduce((a, b) => a.id > b.id ? a : b).id + 1;
      lista.add(p);
    }
  }
}
