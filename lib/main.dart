import 'package:first_app_lelkov/constants/routes.dart';
import 'package:first_app_lelkov/helpers/loading/loading_screen.dart';
import 'package:first_app_lelkov/services/auth/bloc/auth_bloc.dart';
import 'package:first_app_lelkov/services/auth/bloc/auth_event.dart';
import 'package:first_app_lelkov/services/auth/bloc/auth_state.dart';
import 'package:first_app_lelkov/services/auth/firebase_auth_provider.dart';
import 'package:first_app_lelkov/view/forgot_password_view.dart';
import 'package:first_app_lelkov/view/login_view.dart';
import 'package:first_app_lelkov/view/notes/create_update_note_view.dart';
import 'package:first_app_lelkov/view/notes/notes_view.dart';
import 'package:first_app_lelkov/view/register_view.dart';
import 'package:first_app_lelkov/view/verify_email_view.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 23, 23, 23)),
        useMaterial3: true,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        creatOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitalize());
    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
          context: context,
          text: state.loadingText ?? "Please wait a moment",
        );
      } else {
        LoadingScreen().hide();
      }
    }, builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return const NotesView();
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmaliView();
      } else if (state is AuthStateLoggedOut) {
        return const LoginView();
      } else if (state is AuthStateForgotPassword) {
        return const ForgotPasswordview();
      } else if (state is AuthStateRegistering) {
        return const RegisterView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
