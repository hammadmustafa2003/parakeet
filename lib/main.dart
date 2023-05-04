// ignore_for_file: camel_case_types
import 'login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: "Montserrat",
      ),
      home: const LoginPage(title: 'Flutter Demo Home Page'),
       getPages: [
        GetPage(name: '/', page: () => const LoginPage(title: 'flutter')),
        GetPage(name: '/chat', page: () => const ChatScreen()),
      ],
    );
  }
}



