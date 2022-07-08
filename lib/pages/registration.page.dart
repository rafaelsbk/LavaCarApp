import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:lavacarapp/pages/home.page.dart';
import 'package:lavacarapp/pages/welcome.page.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formkey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _funcaoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastrar Novo Usuário'),
      ),
      body: Form(
        key: _formkey,
        child: ListView(
          children: [
            TextFormField(
              controller: _nomeController,
              decoration: InputDecoration(label: Text('Nome Completo')),
            ),
            TextFormField(
              controller: _emailController,
              decoration: InputDecoration(label: Text('E-mail')),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: InputDecoration(label: Text('Senha')),
            ),
            TextFormField(
              controller: _telefoneController,
              decoration: InputDecoration(label: Text('Telefone')),
            ),
            TextFormField(
              controller: _funcaoController,
              decoration: InputDecoration(label: Text('Função')),
            ),
            ElevatedButton(
              onPressed: () async {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (_formkey.currentState!.validate()) {
                  bool accepted = await registration();
                  if (!currentFocus.hasPrimaryFocus) {
                    currentFocus.unfocus();
                  }
                  if (accepted) {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WelcomePage(),
                      ),
                    );
                  } else {
                    _emailController.clear();
                    _passwordController.clear();
                    _funcaoController.clear();
                    _telefoneController.clear();
                    _emailController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                }
              },
              child: Text('Cadastrar usuario'),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> registration() async {
    var url = Uri.parse('http://10.0.0.122:3000/user');
    var response = await http.post(
      url,
      body: {
        'email': _emailController.text,
        'password': _passwordController.text,
        'nomeCompleto': _nomeController.text,
        'telefone': _telefoneController.text,
        'funcao': _funcaoController.text
      },
    );
    if (response.statusCode == 201) {
      print(jsonDecode(response.body));
      return true;
    } else {
      print(jsonDecode(response.body));
      return false;
    }
  }

  final snackBar = SnackBar(
    content: Text('O Cadastro Falhou, verifique os campos.',
        textAlign: TextAlign.center),
    backgroundColor: Colors.redAccent,
  );
}
