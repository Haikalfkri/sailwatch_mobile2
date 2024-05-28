import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sailwatch_mobile/Pages/Homepage/home_page.dart';
import 'firebase_options.dart';
import 'package:intl/date_symbol_data_local.dart' as intl_local;

import 'package:sailwatch_mobile/Pages/BottomNavigationBar/navigationBar.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await intl_local.initializeDateFormatting('id', null);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF060821)
      ),
      debugShowCheckedModeBanner: false,
      home: const navigationBar(),   
    );
  }
}
