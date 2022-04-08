import 'package:flutter/material.dart';
import 'package:loja_virtual/model/user_model.dart';
import 'package:loja_virtual/screens/signup_screen.dart';
import 'package:scoped_model/scoped_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _globalKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Entrar"),
        centerTitle: true,
        actions: <Widget>[
          ElevatedButton(
            style: ElevatedButton.styleFrom(shadowColor: Colors.transparent),
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: ((context) => const SignupScreen()),
                ),
              );
            },
            child: const Text(
              "CRIAR CONTA",
              style: TextStyle(fontSize: 15),
            ),
          ),
        ],
      ),
      body: ScopedModelDescendant<UserModel>(builder: (context, child, model) {
        if (model.isLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return Form(
          key: _globalKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TextFormField(
                controller: _emailController,
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
                controller: _passController,
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
              Align(
                alignment: Alignment.centerRight,
                child: GestureDetector(
                  child: const Padding(
                    child: Text("Esqueci minha senha"),
                    padding: EdgeInsets.only(top: 10),
                  ),
                  onTap: () {},
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                height: 44,
                child: ElevatedButton(
                  onPressed: () {
                    if (_globalKey.currentState!.validate()) {}
                    model.signIn(
                        email: _emailController.text,
                        pass: _passController.text,
                        onSuccess: _onSuccess,
                        onFail: _onFail);
                  },
                  child: const Text(
                    "Entrar",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _onSuccess() {
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text('Falha entrar!'),
      backgroundColor: Colors.red,
      duration: Duration(seconds: 2),
    ));
  }
}
