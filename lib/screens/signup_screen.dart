import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final _globalKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar Conta"),
        centerTitle: true,
      ),
      body: Form(
        key: _globalKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              textCapitalization: TextCapitalization.words,
              decoration: const InputDecoration(hintText: "Nome Completo"),
              validator: (text) {
                if (text == null) {
                  return "Nome inválido";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "E-mail"),
              keyboardType: TextInputType.emailAddress,
              validator: (text) {
                if (text == null || !text.contains("@")) {
                  return "E-mail inválido";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Senha"),
              obscureText: true,
              validator: (text) {
                if (text == null || text.length < 6) {
                  return "Senha inválida";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: "Endereço"),
              validator: (text) {
                if (text == null) {
                  return "Endereço inválido";
                } else {
                  return null;
                }
              },
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 44,
              child: ElevatedButton(
                onPressed: () {
                  if (_globalKey.currentState!.validate()) {}
                },
                child: const Text(
                  "Criar Conta",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
