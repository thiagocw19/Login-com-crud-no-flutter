import 'package:flutter/material.dart';
import 'package:trabalhofinal/models/controladora_produtos.dart';

class TelaProdutos extends StatefulWidget {
  const TelaProdutos({super.key});

  @override
  State<TelaProdutos> createState() => _TelaProdutosState();
}

class _TelaProdutosState extends State<TelaProdutos> {
  late final Controladora _control;

  @override
  void initState() {
    super.initState();
    _control = Controladora();
    _control.lista.add(
      Produtos(
        id: 2,
        nome: 'maça',
        unidade: '2 kg',
        estoque: 3,
        preco: 10,
        status: 1,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produtos'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => TelaEdicaoProduto(
                        produto: Produtos(
                          id: 0,
                          nome: '',
                          unidade: '',
                          estoque: 0,
                          preco: 0.0,
                          status: 1,
                        ),
                        control: _control,
                      ),
                ),
              ).then((_) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _control.lista.length,
        itemBuilder: (context, index) {
          var produto = _control.lista[index];
          return ListTile(
            title: Text(produto.nome),
            subtitle: Text(
              'ID: ${produto.id}\n${produto.preco} Reais\nEstoque: ${produto.estoque}\nUnidade: ${produto.unidade}\nStatus: ${produto.status}',
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => TelaEdicaoProduto(
                              produto: produto,
                              control: _control,
                            ),
                      ),
                    ).then((_) {
                      setState(() {});
                    });
                  },
                ),
                IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _control.excluirProduto(produto.id);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${produto.nome} removido')),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class TelaEdicaoProduto extends StatelessWidget {
  final Produtos produto;
  final Controladora control;

  TelaEdicaoProduto({required this.produto, required this.control});

  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleUnidade = TextEditingController();
  final TextEditingController _controleEstoque = TextEditingController();
  final TextEditingController _controlePreco = TextEditingController();
  final TextEditingController _controleStatus = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controleNome.text = produto.nome;
    _controleUnidade.text = produto.unidade;
    _controleEstoque.text = produto.estoque.toString();
    _controlePreco.text = produto.preco.toStringAsFixed(2);
    _controleStatus.text = produto.status.toString();

    return Scaffold(
      appBar: AppBar(
        title: Text(produto.id > 0 ? 'Editar ${produto.nome}' : 'Novo Produto'),
      ),
      body: Form(
        key: form_key,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextFormField(
                initialValue:
                    produto.id > 0 ? produto.id.toString() : 'Novo Registo',
                enabled: false,
                decoration: InputDecoration(labelText: 'ID'),
              ),
              TextFormField(
                // initialValue: produto.nome,
                controller: _controleNome,
                decoration: InputDecoration(labelText: 'Nome'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o nome';
                  }
                  return null;
                },
              ),
              TextFormField(
                // initialValue: produto.unidade,
                controller: _controleUnidade,
                decoration: InputDecoration(labelText: 'Unidade'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a unidade';
                  }
                  return null;
                },
              ),
              TextFormField(
                // initialValue: produto.estoque.toString(),
                controller: _controleEstoque,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Estoque'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o estoque';
                  }
                  return null;
                },
              ),
              TextFormField(
                // initialValue: produto.preco.toStringAsFixed(2),
                controller: _controlePreco,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(labelText: 'Preço'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o preço';
                  }
                  return null;
                },
              ),
              TextFormField(
                // initialValue: produto.status.toString(),
                controller: _controleStatus,
                decoration: InputDecoration(
                  labelText: 'Status (1 => ativo, 0 => inativo)',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o status';
                  }
                  if (value != '0' && value != '1') {
                    return 'O status deve ser 0 ou 1';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (form_key.currentState!.validate()) {
                    produto.nome = _controleNome.text;
                    produto.unidade = _controleUnidade.text;
                    produto.estoque =
                        int.tryParse(_controleEstoque.text) ?? produto.estoque;
                    produto.preco =
                        double.tryParse(_controlePreco.text) ?? produto.preco;
                    produto.status =
                        int.tryParse(_controleStatus.text) ?? produto.status;

                    control.salvarProduto(produto);

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          produto.id == 0
                              ? '${produto.nome} adicionado'
                              : '${produto.nome} atualizado',
                        ),
                      ),
                    );
                  }
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
