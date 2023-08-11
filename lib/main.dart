import 'package:abora_client/constants/vars.dart';
import 'package:abora_client/firebase_options.dart';
import 'package:abora_client/pages/main_page.dart';
import 'package:abora_client/pages/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'dart:io';

// Global Vars
bool _userLoggedIn = false;
File? file;

void main() async {
// initialize
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

// check user LoggedIn
  if (prefs.getBool(SharedPrefVal().userLoggedIn) != null) {
    _userLoggedIn = prefs.getBool(SharedPrefVal().userLoggedIn)!;
    if (prefs.getString(SharedPrefVal().profilePic) != null) {
      file = File(prefs.getString(SharedPrefVal().profilePic)!);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: _userLoggedIn ? const MainPage() : const LoginPage(),
    );
  }
}
