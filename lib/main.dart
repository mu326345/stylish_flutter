import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:stylish_flutter/home/home_page.dart';
import 'package:stylish_flutter/map/map_page.dart';
import 'package:stylish_flutter/pay/pay_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        //定義跳轉頁面的route
        initialRoute: '/',
        routes: {
          '/map': (context) => MapPage(),
          '/pay': (context) => PayPage(),
        },
        home: Builder(
          builder: (context) => Scaffold(
            appBar: AppBar(
              title: Image.asset(
                'images/Image_Logo02.png',
                fit: BoxFit.fitHeight,
                height: 20,
              ),
              backgroundColor: const Color(0xFFEEF1F7),
              centerTitle: true   ,
              actions: <Widget>[
                //Map
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/map');
                  },
                  icon: Icon(Icons.map),
                  color: Colors.black,
                ),
                //Shopping Cart
                IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, '/pay');
                  },
                  icon: Icon(Icons.add_shopping_cart),
                  color: Colors.black,
                )
              ],
            ),
            body: HomePage(),
          ),
        ));
  }
}
