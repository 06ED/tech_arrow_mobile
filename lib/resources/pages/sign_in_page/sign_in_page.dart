import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app/app/controllers/user_controller.dart';
import 'package:flutter_app/resources/pages/pages.dart';
import 'package:flutter_app/resources/widgets/text_field.dart';
import 'package:nylo_framework/nylo_framework.dart';

import '../../../app/models/user.dart';

class SignInPage extends NyStatefulWidget<UserController> {
  static const path = '/sign_in';

  SignInPage() : super(path, child: _SignInPageState());
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

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
          Image.asset(
            'image.png',
            fit: BoxFit.cover,
          ).localAsset(),
          BackdropFilter(
            child: Container(
              color: Colors.black12,
            ),
            filter: ImageFilter.blur(sigmaY: 10, sigmaX: 10),
          ),
          Container(
            margin: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(height: 50.0),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 50.0,
                  backgroundImage:
                      AssetImage('public/assets/app_icon/icon.png'),
                ),
                SizedBox(height: 20.0),
                Text(
                  'Привет',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 88, 181, 255),
                  ),
                ),
                Text(
                  'Войдите чтобы продолжить',
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromARGB(255, 88, 181, 255),
                  ),
                ),
                SizedBox(height: 50.0),
                MyTextField(
                  controller: _emailController,
                  labelText: 'Почта',
                  label: 'Почта',
                  height: 50,
                ),
                SizedBox(height: 30.0),
                MyTextField(
                  controller: _passwordController,
                  labelText: 'Пароль',
                  label: 'Пароль',
                  height: 50,
                ),
                SizedBox(height: 30.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () => routeTo(SignUpPage.path),
                      child: Text('Регистрация'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                            Color.fromARGB(255, 148, 207, 255)),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                            side: BorderSide(color: Colors.white))),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        final isCorrect = await widget.controller.login(
                          _emailController.text,
                          _passwordController.text,
                        );
                        if (!isCorrect) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text("Неправильная почта или пароль")));
                          return;
                        }

                        await Auth.login(User(_emailController.text));
                        routeTo(DashboardPage.path);
                      },
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
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
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
}
