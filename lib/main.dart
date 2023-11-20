import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:first_app_lelkov/firebase_options.dart';
import 'package:first_app_lelkov/view/login_view.dart';
import 'package:first_app_lelkov/view/register_view.dart';
import 'package:first_app_lelkov/view/verify_email_view.dart';

import 'package:flutter/material.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme:
            ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 23, 23, 23)),
        useMaterial3: true,
      ),
      home: const HomePage(),
      routes: {
        '/login/': (context) => const LoginView(),
        '/register/': (context) => const RegisterView(),
        '/notes/': (context) => const NotesView(),
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final user = FirebaseAuth.instance.currentUser;
            if (user != null) {
              // if (user.emailVerified) {
              return const NotesView();
              // } else {
              //   return const VerifyEmaliView();
              // }
            } else {
              return const LoginView();
            }

          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}

enum MenuAction { logout }

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(
            onSelected: (value) async {
              switch (value) {
                case MenuAction.logout:
                  final shouldLogout = await showLogOutDialog(context);
                  if (shouldLogout) {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      '/login/',
                      (_) => false,
                    );
                  }
              }
            },
            itemBuilder: (context) {
              return const [
                PopupMenuItem<MenuAction>(
                  value: MenuAction.logout,
                  child: Text("Logout"),
                ),
              ];
            },
          )
        ],
      ),
      body: const Text("Hellow world"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Sing out'),
        content: const Text('Вы точно хотите выйти из системы?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(false);
            },
            child: const Text("Отмена"),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(true);
            },
            child: const Text("Выйти"),
          )
        ],
      );
    },
  ).then((value) => value ?? false);
}
