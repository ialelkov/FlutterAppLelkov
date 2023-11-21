import 'package:firebase_auth/firebase_auth.dart';
import 'package:first_app_lelkov/constants/routes.dart';
import 'package:flutter/material.dart';

class VerifyEmaliView extends StatefulWidget {
  const VerifyEmaliView({super.key});

  @override
  State<VerifyEmaliView> createState() => _VerifyEmaliViewState();
}

class _VerifyEmaliViewState extends State<VerifyEmaliView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Проверка эдектронной почты"),
      ),
      body: Column(
        children: [
          const Text(
              "Письмо верификации отправленно, пожалуйста, откройте его"),
          const Text("Если вы не получили письмо, нажмите на кнопку ниже"),
          TextButton(
            onPressed: () async {
              final user = FirebaseAuth.instance.currentUser;
              await user?.sendEmailVerification();
            },
            child: const Text("Отправка верификации почты"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushNamedAndRemoveUntil(
                registerRoute,
                (route) => false,
              );
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
