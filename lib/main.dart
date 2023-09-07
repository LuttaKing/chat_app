import 'package:chat_app/service/notif.dart';
import 'package:chat_app/firebase_options.dart';
// ignore: unused_import
import 'package:chat_app/pages/login.dart';
import 'package:chat_app/pages/register.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      builder: (context, child) {
         return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
      },
      providers: [
      ChangeNotifierProvider(
          create: (context) => MainNotifier(),
        ),
    ]);
   
  }
}


 