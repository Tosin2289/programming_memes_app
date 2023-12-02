import 'package:flutter/material.dart';
import 'package:memes_app/pages/homepage.dart';
import 'package:memes_app/pages/swiper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: MyHomePage(),
    );
  }
}
