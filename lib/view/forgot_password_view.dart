import 'package:first_app_lelkov/services/auth/bloc/auth_bloc.dart';
import 'package:first_app_lelkov/services/auth/bloc/auth_event.dart';
import 'package:first_app_lelkov/services/auth/bloc/auth_state.dart';
import 'package:first_app_lelkov/utilites/dialogs/error_dialog.dart';
import 'package:first_app_lelkov/utilites/dialogs/password_reset_email_sent_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordview extends StatefulWidget {
  const ForgotPasswordview({super.key});

  @override
  State<ForgotPasswordview> createState() => _ForgotPasswordviewState();
}

class _ForgotPasswordviewState extends State<ForgotPasswordview> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            await showErrorDialog(
                context, "We could not process your request.");
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Forgot password"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Text("If you forgot your password, enter your email"),
              TextField(
                keyboardType: TextInputType.emailAddress,
                autocorrect: false,
                autofocus: true,
                controller: _controller,
                decoration:
                    const InputDecoration(hintText: "Your email adress..."),
              ),
              TextButton(
                onPressed: () {
                  final email = _controller.text;
                  context
                      .read<AuthBloc>()
                      .add(AuthEventForgotPassword(email: email));
                },
                child: const Text("Send me password reset link"),
              ),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                },
                child: const Text("Back to login page"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
