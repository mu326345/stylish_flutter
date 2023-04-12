import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stylish_flutter/home/home_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'images/Image_Logo02.png',
              fit: BoxFit.fitHeight,
              height: 20,
            ),
            backgroundColor: const Color(0xFFEEF1F7),
          ),
          body: HomePage()),
    );
  }
}