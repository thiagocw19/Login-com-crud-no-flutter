import 'package:flutter/material.dart';
import 'package:trabalhofinal/models/controladora_usuarios.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final Controladora _control = Controladora();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool _obscureText = true;
  final TextEditingController _controleNome = TextEditingController();
  final TextEditingController _controleSenha = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Login',
            style: TextStyle(
              fontSize: 35,
              color: Colors.amber,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      keyboardType: TextInputType.name,
                      controller: _controleNome,
                      decoration: const InputDecoration(
                        labelText: 'Nome',
                        hintText: 'Entre com seu nome',
                        suffixIcon: Icon(Icons.email),
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        return value!.isEmpty ? 'Preencha o seu nome' : null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50),
                    child: TextFormField(
                      obscureText: _obscureText,
                      keyboardType: TextInputType.visiblePassword,
                      controller: _controleSenha,
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        hintText: 'Entre com sua senha',
                        suffixIcon: IconButton(
                          icon: Icon(
                            _obscureText
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _obscureText = !_obscureText;
                            });
                          },
                        ),
                        border: const OutlineInputBorder(),
                      ),
                      validator: (value) {
                        return value!.isEmpty ? 'Preencha a sua senha' : null;
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 160),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          String nome = _controleNome.text;
                          String senha = _controleSenha.text;

                          if (_control.login(nome, senha)) {
                            Navigator.pushNamed(context, '/inicio');
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('Login Realizado')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Nome ou senha incorretos.'),
                              ),
                            );
                          }
                        }
                      },
                      child: Text('Login'),
                      color: Colors.amber,
                      textColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
