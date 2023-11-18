import 'package:firebase_auth/firebase_auth.dart';
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
          const Text("Пожалуйста верифицируйте свой емайл адрес:"),
          TextButton(
              onPressed: () async {
                final user = FirebaseAuth.instance.currentUser;
                await user?.sendEmailVerification();
              },
              child: const Text("Отправка верификации почты"))
        ],
      ),
    );
  }
}
