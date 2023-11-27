import 'package:first_app_lelkov/constants/routes.dart';
import 'package:first_app_lelkov/services/auth/auth_service.dart';
import 'package:first_app_lelkov/services/auth/bloc/auth_bloc.dart';
import 'package:first_app_lelkov/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            onPressed: () {
              context.read<AuthBloc>().add(
                    const AuthEventSentEmailVerification(),
                  );
            },
            child: const Text("Отправка верификации почты"),
          ),
          TextButton(
            onPressed: () async {
              context.read<AuthBloc>().add(
                    const AuthEventLogOut(),
                  );
            },
            child: const Text("Restart"),
          ),
        ],
      ),
    );
  }
}
