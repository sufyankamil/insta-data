import 'package:flutter/material.dart';
import 'package:instagram_data/screen/home.dart';
import 'package:instagram_data/screen/splash.dart';
import 'package:provider/provider.dart';

import 'providers/insta_provider.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => InstaUsers()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Splash(),
        routes: {
          '/home': (context) => const Home(),
        },
      ),
    );
  }
}
