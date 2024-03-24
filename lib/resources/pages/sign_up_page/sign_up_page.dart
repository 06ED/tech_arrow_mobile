import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/user_controller.dart';
import 'package:flutter_app/resources/pages/pages.dart';
import 'package:flutter_app/resources/widgets/text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../app/models/user.dart';

class SignUpPage extends NyStatefulWidget<UserController> {
  static const path = '/sign_up';

  SignUpPage() : super(path, child: _SignUpPageState());
}

class _SignUpPageState extends State<SignUpPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _repeatPasswordController = TextEditingController();

  final _formKey = GlobalKey<FormState>(); // GlobalKey для формы

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Color.fromARGB(255, 179, 222, 255),
                  Color.fromARGB(255, 88, 181, 255),
                ],
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            child: Image.asset('one.png').localAsset(),
          ),
          SafeArea(
            child: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  backgroundImage:
                      AssetImage('public/assets/app_icon/icon.png'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Привет',
                  style: GoogleFonts.caveat(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Войдите чтобы продолжить',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 40.0),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        MyTextField(
                          controller: _emailController,
                          labelText: 'Почта',
                          height: 50,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите вашу почту';
                            }
                            if (!isValidEmail(value)) {
                              return 'Пожалуйста, введите корректный адрес электронной почты';
                            }
                            return null; // Возвращаем null, если валидация успешна
                          },
                        ),
                        SizedBox(height: 20.0),
                        MyTextField(
                          controller: _passwordController,
                          labelText: 'Пароль',
                          height: 50,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, введите ваш пароль';
                            }
                            // Дополнительные проверки пароля могут быть добавлены здесь
                            return null; // Возвращаем null, если валидация успешна
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        MyTextField(
                          controller: _repeatPasswordController,
                          labelText: 'Повторите пароль',
                          height: 50,
                          validate: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Пожалуйста, повторите ваш пароль';
                            }
                            if (value != _passwordController.text) {
                              return 'Пароли не совпадают';
                            }
                            return null; // Возвращаем null, если валидация успешна
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => routeTo(SignInPage.path),
                      child: Text(
                        'Вход',
                        style: TextStyle(fontWeight: FontWeight.w900),
                      ),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 88, 181, 255),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10.0)),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // Проверяем совпадение паролей
                          if (_passwordController.text !=
                              _repeatPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Пароли не совпадают")),
                            );
                            return;
                          }

                          // Регистрация пользователя
                          await widget.controller.register(
                            _emailController.text,
                            _passwordController.text,
                          );

                          // Вход пользователя после успешной регистрации
                          await Auth.login(User(_emailController.text));

                          // Переход на страницу Dashboard
                          routeTo(DashboardPage.path);
                        }
                      },
                      child: Text('Регистрация'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          Color.fromARGB(255, 148, 207, 255),
                        ),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  bool isValidEmail(String email) {
    final bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
    return emailValid;
  }
}
