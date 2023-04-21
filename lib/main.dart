// ignore_for_file: use_key_in_widget_constructors, no_leading_underscores_for_local_identifiers, unused_element
import 'package:flutter/material.dart';
import './views/register_view.dart';
import './views/login_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const HomePage(),
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = FirebaseAuth.instance.currentUser;
              if (user?.emailVerified ?? false) {
                return const Text('Email verified user');
              } else {
                print('Email is not verified');
              }

              return const Text('Done');
            default:
              return const Text('Loading...');
          }
        },
      ),
    );
  }
}
