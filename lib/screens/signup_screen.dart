import 'package:cointacao/models/user_model.dart';
import 'package:cointacao/stores/user_store.dart';
import 'package:cointacao/utils/routes.dart';
import 'package:cointacao/widgets/button_widget.dart';
import 'package:cointacao/widgets/input_widget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Criar conta",
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
                    labelText: "Nome",
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu nome';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    labelText: "Email",
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu e-mail';
                      }

                      var emailREgex =
                          RegExp(r'^[a-zA-Z0-9._]+@[a-zA-Z0-9]+\.[a-zA-Z]+$');
                      if (!emailREgex.hasMatch(value)) {
                        return 'Por favor, insira um e-mail válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    labelText: "Celular",
                    controller: _phoneController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira seu número de celular';
                      }

                      var phoneRegex = RegExp(r'^\d{10,11}$');
                      if (!phoneRegex.hasMatch(value)) {
                        return 'Por favor, insira um número de celular válido';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    labelText: "Data de Nascimento (dd/mm/yyyy)",
                    controller: _birthdayController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, insira sua data de nascimento';
                      }

                      var dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
                      if (!dateRegex.hasMatch(value)) {
                        return 'Data deve estar no formato dd/mm/yyyy';
                      }

                      try {
                        DateTime parsedDate =
                            DateFormat('dd/MM/yyyy').parseStrict(value);

                        if (parsedDate.isAfter(DateTime.now())) {
                          return 'Data de nascimento não pode ser futura';
                        }
                      } catch (e) {
                        return 'Data inválida';
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
                  const SizedBox(height: 16.0),
                  CustomInputField(
                    labelText: "Confirme a senha",
                    obscureText: true,
                    controller: _confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, confirme sua senha';
                      }

                      if (value != _passwordController.text) {
                        return 'As senhas não coincidem';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 64.0),
                  CustomButton(
                    text: "Já tem cadastro?",
                    type: "secondary",
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.login);
                    },
                  ),
                  const SizedBox(height: 16.0),
                  CustomButton(
                    text: "Continuar",
                    type: "primary",
                    isLoading: _isLoading,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          _isLoading = true;
                        });

                        UserModel user = UserModel(
                            name: _nameController.text,
                            email: _emailController.text,
                            phone: _phoneController.text,
                            birthday: _birthdayController.text,
                            password: _passwordController.text,
                            coins: List.empty());

                        store.createUser(user).then((user) {
                          if (user != null) {
                            Navigator.pushNamed(context, AppRoutes.main);
                          }
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
