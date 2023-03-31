import 'package:flutter/material.dart';
import 'package:stylish_flutter/detail_page.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 3,
          child: topHoriListView(),
        ),
        Expanded(
          flex: 7,
          child: isSmall(context)
              //小畫面時的View
              ? SingleChildScrollView(
                  child: Column(
                  children: [
                    ExpansionTile(
                      title: Text('女裝'),
                      children: <Widget>[
                        productVertiListView(),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('男裝'),
                      children: <Widget>[
                        productVertiListView(),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('配件'),
                      children: <Widget>[
                        productVertiListView(),
                      ],
                    ),
                  ],
                ))

              //這是大畫面時的view
              : Row(children: [
                  Expanded(child: categoryVertiListView('女裝')),
                  Expanded(child: categoryVertiListView('男裝')),
                  Expanded(child: categoryVertiListView('配件')),
                ]),
        )
      ],
    );
  }

// 上方水平畫面元件區
  Widget topImageCard() {
    return SizedBox(
      width: 300,
      height: 250,
      child: Card(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Image.asset(
          'images/Image_Logo02.png',
          fit: BoxFit.contain,
        ),
      ),
    );
  }

  Widget topHoriListView() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      itemBuilder: (context, index) => topImageCard(),
      padding: EdgeInsets.all(5),
    );
  }

//下方畫面元件區
  Widget productCard() {
    return Container(
      width: 300,
      height: 180,
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              Expanded(
                  flex: 4,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                  )),
              Expanded(
                  flex: 6,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [Text('Uniqlo is good'), Text('NT\$ 343')],
                    ),
                  ))
            ],
          )),
    );
  }

//垂直商品卡片ListView
  Widget productVertiListView() {
    return ListView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: 6,
      itemBuilder: (context, index) => InkWell(
        child: productCard(),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const DetailPage(title: 'heyyy')));
        },
      ),
      padding: const EdgeInsets.all(5),
    );
  }

//類別+商品卡ListView
  Widget categoryVertiListView(String category) {
    return Column(children: [
      Text(category),
      Expanded(
          child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 6,
        itemBuilder: (context, index) => InkWell(
          child: productCard(),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const DetailPage(title: ('aaaa'))));
          },
        ),
        padding: const EdgeInsets.all(5),
      ))
    ]);
  }
}

class Product {
  final String title;
  final String id;
  final Map<String, Map<String, int>> stock; // 使用 Map 來記錄每種顏色、尺寸的庫存
  final String price;

  Product(
      {required this.title,
      required this.id,
      required this.stock,
      required this.price});
}
