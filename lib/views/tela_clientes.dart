import 'package:flutter/material.dart';
import 'package:trabalhofinal/models/controladora_clientes.dart';

class TelaClientes extends StatefulWidget {
  const TelaClientes({super.key});

  @override
  State<TelaClientes> createState() => _TelaClientesState();
}

class _TelaClientesState extends State<TelaClientes> {
  late final Controladora _control;

  @override
  void initState() {
    super.initState();
    _control = Controladora();
    _control.lista.add(
      Cliente(
        id: 2,
        nome: 'testeCNPJ',
        tipo: 'J',
        cadastro: '12.345.678/0001-00',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => TelaEdicaoCliente(
                        cliente: Cliente(
                          id: 0,
                          nome: '',
                          tipo: '',
                          cadastro: '',
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
          var cliente = _control.lista[index];
          return ListTile(
            title: Text(cliente.nome),
            subtitle: Text(
              'ID: ${cliente.id}\n'
              'Tipo: ${cliente.tipo == 'F' ? 'Pessoa Física' : 'Pessoa Jurídica'}\n'
              '${cliente.tipo == 'F' ? 'CPF' : 'CNPJ'}: ${cliente.cadastro}',
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
                            (context) => TelaEdicaoCliente(
                              cliente: cliente,
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
                    _control.excluirCliente(cliente.id);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${cliente.nome} removido')),
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

class TelaEdicaoCliente extends StatelessWidget {
  final Cliente cliente;
  final Controladora control;

  TelaEdicaoCliente({required this.cliente, required this.control});

  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleTipo = TextEditingController();
  final TextEditingController _controleCadastro = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _controleNome.text = cliente.nome;
    _controleTipo.text = cliente.tipo;
    _controleCadastro.text = cliente.cadastro;

    return Scaffold(
      appBar: AppBar(
        title: Text(cliente.id > 0 ? 'Editar ${cliente.nome}' : 'Novo Cliente'),
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
                    cliente.id > 0 ? cliente.id.toString() : 'Novo Registo',
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
                controller: _controleTipo,
                decoration: InputDecoration(
                  labelText: 'Tipo (F - Física / J - Jurídica)',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o tipo';
                  }
                  if (value != 'F' && value != 'J') {
                    return 'Escolha entre F ou J';
                  }
                  return null;
                },
              ),
              TextFormField(
                // initialValue: produto.estoque.toString(),
                controller: _controleCadastro,
                decoration: InputDecoration(labelText: 'CPF/CNPJ'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe o tipo de cadastro';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (form_key.currentState!.validate()) {
                    cliente.nome = _controleNome.text;
                    cliente.tipo = _controleTipo.text;
                    cliente.cadastro = _controleCadastro.text;

                    control.salvarCliente(cliente);

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          cliente.id == 0
                              ? '${cliente.nome} adicionado'
                              : '${cliente.nome} atualizado',
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
