import 'package:base_test/Screens/Startscreen.dart';
import 'package:base_test/Screens/signup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'CRUD/crudSignIn.dart';
import 'CRUD/crudSignUp.dart';
import 'Screens/Login.dart';
import 'Screens/Messaging.dart';
import 'firebase_options.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
  MessagingClass().init();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(


      home:crudSignIn(),
    );
  }
}
