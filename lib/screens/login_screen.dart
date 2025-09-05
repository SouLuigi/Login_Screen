import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Chave para identificar e controlar o nosso formulário.
  final _formKey = GlobalKey<FormState>();

  // Controladores para ler os valores dos campos email e senha.
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Variavel de estato para controlar visibilidade da senha.
  bool _isPasswordVisible = false;

  @override
  void dispose() {
    // Limpar os controladores com widget for descartado.
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _Login() {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        // Se o formulário for válido, exibe uma mensagem e navega.
        const SnackBar(content: Text('Processando Login...')),
      );
      print('Email: ${_emailController.text}');
      print('Senha: ${_passwordController.text}');
      // Navega para a tela principal, substituindo a tela de login na pilha.
      Navigator.pushReplacementNamed(context, '/home');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: const Text('Tela de Login'),
      backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget> [
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email),
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.emailAddress,
                //Validador do campo de e-mail.
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Por favor, insira seu email';
                  }
                  if(!RegExp(r'\S+@\S+\.\S+').hasMatch(value)){
                    return 'Por favor insira um email valido';
                  }
                  return null; // Retorna null se o valor for válido.
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: !_isPasswordVisible,
                decoration: InputDecoration(
                  labelText: 'Senha',
                  prefixIcon: Icon(Icons.lock),
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: (){
                      setState(() {
                        _isPasswordVisible = !_isPasswordVisible;
                      });
                    },
                  ),
                ),
                // validador do campo de senha.
                validator: (value){
                  if(value == null || value.isEmpty){
                    return 'Por favor, insira sua senha';
                  }
                  if(value.length < 6){
                    return 'A senha precisa de 6 caracteres';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _Login,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blueAccent,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Entrar',style: TextStyle(fontSize: 18)),
              )
            ],
          ),
        ),
      )
    );
  }
}
