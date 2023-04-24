import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tappay/flutter_tappay.dart';

class PayPage extends StatefulWidget {
  const PayPage({super.key});
  
  @override
  State<StatefulWidget> createState() => _PayPageState();

}

class _PayPageState extends State<PayPage> {
  static const platform = MethodChannel('com.example.stylish_flutter/getPlatformData');
  String _dataStr = 'get nothing yet';

//TapPay 部分
  FlutterTappay payer = FlutterTappay ();
  String _token = "";
  bool prepared = false;

  late TextEditingController _cardNumber;
  late TextEditingController _cardMonth;
  late TextEditingController _cardYear;
  late TextEditingController _cardCCV;

  bool _isCardNumberValid = true;
  bool _isCardCCVValid = true;
  bool _isCardYearValid = true;
  bool _isCardMonthValid = true;
  bool _totalValid = false;

   @override
  void initState() {
    super.initState();
    payer = FlutterTappay();
    payer.init(
        appKey: "app_whdEWBH8e8Lzy4N6BysVRRMILYORF6UxXbiOFsICkz0J9j1C0JUlCHv1tVJC",
        appId: 11334,
        serverType: FlutterTappayServerType.Sandbox
    ).then((_){
      setState(() {
        prepared = true;
      });
    });

    validator() {
      payer.validate(
        cardNumber: _cardNumber.text,
        dueMonth: _cardMonth.text,
        dueYear: _cardYear.text,
        ccv: _cardCCV.text,
      ).then((validationResult) {
        bool cardValid = validationResult.isCardNumberValid;
        bool dateValid = validationResult.isExpiryDateValid;
        bool ccvValid = validationResult.isCCVValid;
        _totalValid = cardValid && ccvValid && dateValid;
        if(cardValid == true)
          _isCardNumberValid = true;
        else
          _isCardNumberValid = _cardNumber.text != "" ? false : true;
        if(ccvValid == true)
          _isCardCCVValid = true;
        else
          _isCardCCVValid = _cardCCV.text != "" ? false : true;
        if(dateValid == true) {
          _isCardYearValid = true;
          _isCardMonthValid = true;
        } else {
          _isCardYearValid = _cardYear.text != "" ? false : true;
          _isCardMonthValid = _cardMonth.text != "" ? false : true;
        }

        setState(() {
        });
      });

    }

    _cardNumber = TextEditingController(text: "")..addListener(validator);
    _cardMonth = TextEditingController(text: "")..addListener(validator);
    _cardYear = TextEditingController(text: "")..addListener(validator);
    _cardCCV = TextEditingController(text: "")..addListener(validator);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'images/Image_Logo02.png',
            fit: BoxFit.fitHeight,
            height: 20,
            alignment: Alignment.center,
        ),
      ),
      body: Container(
        child: Column(
          children: [
            //誇平台接資料
            Row(children: [
              ElevatedButton(onPressed: _getPlatformData, child: const Text('Get Android Data')),
              Text(_dataStr)
            ],),
            //TapPay畫面
            Text("All validL: $_totalValid"),
            Text("Prepared: $prepared"),
            Text("Token on: $_token"),
            TextFormField(
                autovalidateMode: AutovalidateMode.always, maxLength: 16,
                controller: _cardNumber,
                validator: (v) => _isCardNumberValid ? null : "卡號不正確",
              ),
              Row(children: <Widget>[
                SizedBox(
                   width: 48,
                   child: TextFormField(
                    autovalidateMode: AutovalidateMode.always, controller: _cardMonth,
                    validator: (v) => _isCardMonthValid ? null : "月份不正確",
                    maxLength: 2,
                   ),
                ),
                SizedBox(
                  width: 48,
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.always, controller: _cardYear,
                    validator: (v) => _isCardYearValid ? null : "年份不正確",
                    maxLength: 2,
                  ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 48,
                    child: TextFormField(
                      autovalidateMode: AutovalidateMode.always, controller: _cardCCV,
                      validator: (v) => _isCardCCVValid ? null : "CCV不正確",
                      maxLength: 3,
                    ),
                  )
              ],)
          ],
        )
      ),

      floatingActionButton: Builder(
        builder: (context) {
          return FloatingActionButton(
            child: Icon(Icons.send),
            onPressed: !_totalValid ? null : () async {
              try {
                TappayTokenResponse response = await payer.sendToken(
                  cardNumber: _cardNumber.text,
                  dueYear: _cardYear.text,
                  dueMonth: _cardMonth.text,
                  ccv: _cardCCV.text,
                );
                setState(() {
                  _token = response.prime;
                });
              } catch(e) {
                print(e.toString());
                // Scaffold.of(context).showSnackBar(
                //   SnackBar(content: Text("金流付款發生錯誤: ${e.toString()}"))
                // );
              }
            },
          );
        }),
    );
    throw UnimplementedError();
  }

  Future<void> _getPlatformData() async {
    String dataStr = "empty";
    try {
      final dynamic result = await platform.invokeMethod('getPlatformData');
      dataStr = result;
    // } on PlatformException catch (e, stacktrace) { //這方法會讓web壞掉
    } on Exception catch (e, stacktrace) {
      print(stacktrace);
      print(e.toString());
      dataStr = "Not Android devices, No Data";
    }

    setState(() {
      _dataStr = dataStr;
    });
  }
}