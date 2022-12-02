import 'package:animated_login/presentation/widgets/email_field.dart';
import 'package:animated_login/presentation/widgets/get_started_button.dart';
import 'package:animated_login/presentation/widgets/messages_screen.dart';
import 'package:animated_login/presentation/widgets/password_field.dart';
import 'package:flutter/material.dart';

import 'package:animated_login/presentation/widgets/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController emailController;
  late TextEditingController passwordController;
  double _elementsOpacity = 1;
  bool loadingBallAppear = false;
  double loadingBallSize = 1;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        bottom: false,
        child: loadingBallAppear
            ? Padding(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30.0),
                child: MessagesScreen())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 50.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70),
                      TweenAnimationBuilder<double>(
                        duration: Duration(milliseconds: 300),
                        tween: Tween(begin: 1, end: _elementsOpacity),
                        builder: (_, value, __) => Opacity(
                          opacity: value,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(Icons.satellite_alt,
                                  size: 80,
                                  color: Color.fromARGB(255, 63, 73, 214)),
                              SizedBox(height: 25),
                              Text(
                                "Bienvenid@,",
                                style: TextStyle(
                                    color: Colors.black, fontSize: 35),
                              ),
                              Text(
                                "Inicia sesión para continuar",
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.7),
                                    fontSize: 35),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 50),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          children: [
                            EmailField(
                                fadeEmail: _elementsOpacity == 0,
                                emailController: emailController),
                            SizedBox(height: 40),
                            PasswordField(
                                fadePassword: _elementsOpacity == 0,
                                passwordController: passwordController),
                            SizedBox(height: 60),
                            GetStartedButton(
                              elementsOpacity: _elementsOpacity,
                              onTap: () {
                                setState(() {
                                  _elementsOpacity = 0;
                                });
                              },
                              onAnimatinoEnd: () async {
                                await Future.delayed(
                                    Duration(milliseconds: 500));
                                setState(() {
                                  loadingBallAppear = true;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => HomePage()),
          );
        },
        backgroundColor: Colors.green,
        child: const Icon(Icons.navigation_sharp),
      ),
    );
  }
}
