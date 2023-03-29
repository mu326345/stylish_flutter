import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
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
          backgroundColor: const Color(0xFFEEF1F7),
        ),
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(
              children: [
                Image.network(
                    'https://www.uniqlo.com/tw/hmall/test/u0000000016349/sku/561/COL60.jpg',),
                Column(children: [
                  Text(
                    'Uniqlo is good',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text('2023032101'),
                  Text('NT\$ 323',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          Divider(color: Colors.black, thickness: 1,)
                ]),
              ],
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(height: 8),
            Text(
              'Product Description',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ]),
        )
        // Placeholder(),
        );
  }
}
