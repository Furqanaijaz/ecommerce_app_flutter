import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/common/bottom_navigation/page/navigation.dart';
import 'package:ecommerce_app/data/auth/model/auth.dart';
import 'package:ecommerce_app/domain/auth/usecase/login_usecase.dart';
import 'package:ecommerce_app/service_locator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  Login({super.key});
  final TextEditingController usename = TextEditingController();
  final TextEditingController password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        minimum: const EdgeInsets.only(top: 100, left: 16, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _singinText(),
            const SizedBox(height: 50),
            _emailField(),
            const SizedBox(height: 20),
            _passwordField(),
            const SizedBox(height: 50),
            _signinButton(context),
          ],
        ),
      ),
    );
  }

  Widget _singinText() {
    return const Text(
      'Sing in',
      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
    );
  }

  Widget _emailField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          controller: usename,
          decoration: InputDecoration(
            hintText: "User Name",
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _passwordField() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: TextField(
          controller: password,

          decoration: InputDecoration(
            hintText: "User Name",
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
              borderSide: BorderSide(color: Colors.black),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }

  Widget _signinButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xfff505081),
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () async {
        try {
          final Either result = await sl<LoginUsecase>().call(
            params: LoginRequest(
              username: usename.text,
              password: password.text,
            ),
          );

          result.fold(
            (failure) {
              print(failure);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Login failed")));
            },
            (response) {
              print(response);

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text("Login success")));
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => Navigations(userData: response),
                ),
              );
            },
          );
        } catch (e) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text("Login failed: $e")));
        }
      },
      child: const Text(
        'Sign In',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget _sigupText(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          const TextSpan(text: "Do you Have account? "),
          TextSpan(
            text: "Signup",
            style: const TextStyle(color: Colors.blue),
            recognizer:
                TapGestureRecognizer()
                  ..onTap = () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Navigator(),
                      ),
                    );
                  },
          ),
        ],
      ),
    );
  }
}
