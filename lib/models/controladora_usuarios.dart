import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';

class Usuarios {
  int id;
  String nome;
  String senha;

  Usuarios({required this.id, required this.nome, required this.senha});

  Usuarios.fromJson(Map<String, dynamic> json)
    : id = json['id'] ?? 0,
      nome = json['nome'],
      senha = json['senha'];

  @override
  String toString() {
    return jsonEncode(toJson());
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'nome': nome, 'senha': senha};
  }
}

class Controladora {
  final List<Usuarios> lista = [Usuarios(id: 1, nome: 'Teste', senha: '123')];
  File? file;

  List<Usuarios> get usuarios => lista;

  void excluirUsuario(int idParaExcluir) {
    lista.removeWhere((usuario) => usuario.id == idParaExcluir);
    salvarLista();
  }

  Future<void> salvarUsuario(Usuarios u) async {
    if (u.id == 0) {
      u.id =
          lista.isEmpty
              ? 1
              : lista.reduce((a, b) => a.id > b.id ? a : b).id + 1;
      lista.add(u);
    }
    await salvarLista();
  }

  bool login(String nome, String senha) {
    if (lista.isEmpty) {
      return nome == 'admin' && senha == 'admin';
    } else {
      return (nome == 'admin' && senha == 'admin') ||
          lista.any((u) => u.nome == nome && u.senha == senha);
    }
  }

  Future<List<Usuarios>> carregarLista() async {
    await path();
    var strArq = await file!.readAsString();

    List<dynamic> lstJson = jsonDecode(strArq);
    var novaLista = lstJson.map((jsonpessoa) => Usuarios.fromJson(jsonpessoa));
    lista.clear();
    lista.addAll(novaLista);
    await Future.delayed(Duration(seconds: 2));
    return lista;
  }

  Future<void> salvarLista() async {
    await path();
    var lstStr = jsonEncode(lista);
    await file!.writeAsString(lstStr);
  }

  Future<void> path() async {
    final Directory tempDir = await getApplicationDocumentsDirectory();
    final Directory customDir = Directory('${tempDir.path}/listajson');
    if (!await customDir.exists()) {
      await customDir.create(recursive: true);
    }
    file = File('${customDir.path}/lista.txt');
    print(customDir.path);
  }
}
