import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _PayPageState();

}

class _PayPageState extends State<PayPage> {
  static const platform = MethodChannel('com.example.stylish_flutter/getPlatformData');
  String _dataStr = 'get nothing yet';

//Tappay
  String _tappayMessage = 'init';
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Image.asset(
                'images/Image_Logo02.png',
                fit: BoxFit.fitHeight,
                height: 20,
              ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              _tappayMessage,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _inputCreditCard,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _inputCreditCard() async {
    String message;

    try {
      final String result = await platform.invokeMethod('tappay');
      message = result;
    } on PlatformException catch (e) {
      message = e.message ?? '';
    }

    setState(() {
      _tappayMessage = message;
    });
  }

  Future<void> _getPlatformData() async {
    print("in function");
    String dataStr = "empty";
    try {
      print('trying');
      final dynamic result = await platform.invokeMethod('getPlatformData');
      print("data = $result");
      dataStr = result;
    } on PlatformException catch (e, stacktrace) {
      print(stacktrace);
      print(e.toString());
    }

    setState(() {
          print('setData');
          _dataStr = dataStr;
        });
  }
}
