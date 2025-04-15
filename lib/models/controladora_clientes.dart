class Cliente {
  int id;
  String nome;
  String tipo;
  String cadastro;

  Cliente({
    required this.id,
    required this.nome,
    required this.tipo,
    required this.cadastro,
  });
}

class Controladora {
  final List<Cliente> lista = [
    Cliente(id: 1, nome: 'testeCPF', tipo: 'F', cadastro: '123.456.789-12'),
  ];

  List<Cliente> get clientes => lista;

  void excluirCliente(int idParaExcluir) {
    lista.removeWhere((cliente) => cliente.id == idParaExcluir);
  }

  void salvarCliente(Cliente c) {
    if (c.id == 0) {
      c.id =
          lista.isEmpty
              ? 1
              : lista.reduce((a, b) => a.id > b.id ? a : b).id + 1;
      lista.add(c);
    }
  }
}
