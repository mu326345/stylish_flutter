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

  @override
  void initState() {
    super.initState();
    _getPlatformData();
  }

  @override
  Widget build(BuildContext context) {
    // return Placeholder();
    return Container(
      child: Text(_dataStr),
    );
    throw UnimplementedError();
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
