import 'package:flutter/material.dart';
import 'package:trabalhofinal/models/controladora_usuarios.dart';

class TelaUsuarios extends StatefulWidget {
  const TelaUsuarios({super.key});

  @override
  State<TelaUsuarios> createState() => _TelaUsuariosState();
}

class _TelaUsuariosState extends State<TelaUsuarios> {
  late final Controladora _control;

  @override
  void initState() {
    super.initState();
    _control = Controladora();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Usuários'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => TelaEdicaoUsuario(
                        usuario: Usuarios(id: 0, nome: '', senha: ''),
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
          var usuario = _control.lista[index];
          return ListTile(
            title: Text(usuario.nome),
            subtitle: Text('ID: ${usuario.id}'),
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
                            (context) => TelaEdicaoUsuario(
                              usuario: usuario,
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
                    _control.excluirUsuario(usuario.id);
                    setState(() {});
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('${usuario.nome} removido')),
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

class TelaEdicaoUsuario extends StatelessWidget {
  final Usuarios usuario;
  final Controladora control;

  TelaEdicaoUsuario({required this.usuario, required this.control});

  final GlobalKey<FormState> form_key = GlobalKey<FormState>();
  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleSenha = TextEditingController();

  // Future<void> salvarJson() async {
  //   SharedPreferences perf = await SharedPreferences.getInstance();
  //   perf.setString('NOME', _controleNome.text);
  //   perf.setString('SENHA', _controleSenha.text);
  // }

  @override
  Widget build(BuildContext context) {
    _controleNome.text = usuario.nome;
    _controleSenha.text = usuario.senha;

    return Scaffold(
      appBar: AppBar(
        title: Text(usuario.id > 0 ? 'Editar ${usuario.nome}' : 'Novo Cliente'),
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
                    usuario.id > 0 ? usuario.id.toString() : 'Novo Registo',
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
                controller: _controleSenha,
                decoration: InputDecoration(labelText: 'Senha'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Informe a senha';
                  }
                  if (value.contains(' ')) {
                    return 'Remova os espaços';
                  }
                  return null;
                },
              ),

              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (form_key.currentState!.validate()) {
                    usuario.nome = _controleNome.text;
                    usuario.senha = _controleSenha.text;

                    control.salvarUsuario(usuario);
                    control.salvarLista();

                    Navigator.pop(context);

                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          usuario.id == 0
                              ? '${usuario.nome} adicionado'
                              : '${usuario.nome} atualizado',
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
