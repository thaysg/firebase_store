import 'package:firebase_store/helpers/validators.dart';
import 'package:firebase_store/models/user.dart';
import 'package:firebase_store/models/user_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// ignore: use_key_in_widget_constructors
class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: Alignment.topCenter, colors: [
          Colors.red[900],
          Colors.red[800],
          Colors.redAccent,
        ])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Row(
                    // ignore: prefer_const_literals_to_create_immutables
                    children: [
                      const Icon(
                        Icons.filter_tilt_shift,
                        color: Colors.white,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        "Garcia Store",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Center(
                    child: Text(
                      "Bem Vindo",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            // ignore: prefer_const_literals_to_create_immutables
                            boxShadow: [
                              const BoxShadow(
                                  color: Color.fromRGBO(225, 95, 27, .3),
                                  blurRadius: 20,
                                  offset: Offset(0, 10))
                            ]),
                        child: Column(
                          children: [
                            Form(
                              key: formKey,
                              child: Consumer<UserManager>(
                                  builder: (_, userManager, __) {
                                return SingleChildScrollView(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Image.asset('images/gs.png'),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.grey[100]),
                                        child: TextFormField(
                                          controller: emailController,
                                          enabled: !userManager.loading,
                                          decoration: const InputDecoration(
                                              hintText: 'E-mail',
                                              prefixIcon: Icon(Icons.person),
                                              border: InputBorder.none),
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          autocorrect: false,
                                          validator: (email) {
                                            if (!emailValid(email)) {
                                              return 'Email Inválido';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            color: Colors.grey[100]),
                                        child: TextFormField(
                                          controller: passController,
                                          enabled: !userManager.loading,
                                          decoration: const InputDecoration(
                                              hintText: 'Senha',
                                              prefixIcon: Icon(
                                                Icons.lock,
                                              ),
                                              border: InputBorder.none),
                                          autocorrect: false,
                                          obscureText: true,
                                          validator: (pass) {
                                            if (pass.isEmpty ||
                                                pass.length < 6) {
                                              return 'Senha Inválida';
                                            }
                                            return null;
                                          },
                                        ),
                                      ),
                                      const Align(
                                        alignment: Alignment.centerRight,
                                        child: FlatButton(
                                            onPressed: null,
                                            padding: EdgeInsets.zero,
                                            child: Text('Esqueci minha senha')),
                                      ),
                                      const SizedBox(
                                        height: 16,
                                      ),
                                      SizedBox(
                                        height: 44,
                                        child: RaisedButton(
                                          onPressed: userManager.loading
                                              ? null
                                              : () {
                                                  if (formKey.currentState
                                                      .validate()) {
                                                    userManager.signIn(
                                                        user: User(
                                                            email:
                                                                emailController
                                                                    .text,
                                                            password:
                                                                passController
                                                                    .text),
                                                        onFail: (e) {
                                                          scaffoldKey
                                                              .currentState
                                                              .showSnackBar(
                                                                  SnackBar(
                                                            content: Text(
                                                              'Falha ao entrar: $e',
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                            backgroundColor:
                                                                Colors.red,
                                                          ));
                                                        },
                                                        onSuccess: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        });
                                                  }
                                                },
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25)),
                                          color: Theme.of(context).primaryColor,
                                          disabledColor: Theme.of(context)
                                              .primaryColor
                                              .withAlpha(100),
                                          textColor: Colors.white,
                                          child: userManager.loading
                                              ? const CircularProgressIndicator(
                                                  valueColor:
                                                      AlwaysStoppedAnimation(
                                                          Colors.red),
                                                )
                                              : const Text(
                                                  'Entrar',
                                                  style:
                                                      TextStyle(fontSize: 18),
                                                ),
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      FlatButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pushReplacementNamed('/sign_up');
                                        },
                                        child: const Text(
                                          'Ainda não Possui uma Conta'
                                          '\nCrie uma Agora',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              }),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
