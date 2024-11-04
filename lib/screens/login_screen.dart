import 'package:cointacao/stores/user_store.dart';
import 'package:cointacao/utils/routes.dart';
import 'package:cointacao/widgets/button_widget.dart';
import 'package:cointacao/widgets/dialog_widget.dart';
import 'package:cointacao/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<UserStore>(context);
    var colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Center(
                    child: Image.asset(
                      'assets/images/logo.png',
                      width: 250,
                    ),
                  ),
                  const SizedBox(height: 64.0),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Fazer login",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          color: colorScheme.primary,
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          fontFamily: "Poppins"),
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    labelText: "Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu e-mail';
                      }

                      var emailRegex =
                          RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Por favor, insira um e-mail válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    labelText: "Senha",
                    obscureText: true,
                    controller: _passwordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua senha';
                      }

                      if (value.length < 6) {
                        return 'A senha deve ter pelo menos 6 caracteres';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 64.0),
                  CustomButton(
                    text: "Cadastrar",
                    type: "secondary",
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.signup);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    text: "Entrar",
                    type: "primary",
                    isLoading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        String email = _emailController.text;
                        String password = _passwordController.text;

                        store.signIn(email, password).then((user) {
                          if (user != null) {
                            Navigator.pushNamed(context, AppRoutes.main);
                          }
                        }).catchError((_) {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return const DialogWidget(
                                title: 'Credenciais inválidas',
                                content: 'Usuário ou senha incorretos',
                              );
                            },
                          );
                        }).whenComplete(() {
                          setState(() {
                            _isLoading = false;
                          });
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
