import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/detail/detail_page.dart';
import 'package:stylish_flutter/models/product.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  final dio = Dio();
  void getHttp() async {
    final response = await dio.get('https://api.appworks-school.tw/api/1.0/products/women');
    // print(response);
    print('go here!!');
}

  //假資料
  final List<Product> products = [
    Product(
        title: '男士休閒外套',
        id: 'men_jacket_001',
        category: 'Men',
        stock: {
          '697723': {'M': 0, 'L': 20},
          'E36F10': {'M': 5, 'L': 15},
        },
        price: '1500'),
    Product(
        title: '男士休閒上衣',
        id: 'men_jacket_002',
        category: 'Men',
        stock: {
          'E36F10': {'M': 10, 'L': 20},
          'C98E5D': {'M': 5, 'L': 15},
          '697723': {'M': 0, 'L': 5},
        },
        price: '1500'),
    Product(
        title: '女士迷你洋裝',
        id: 'women_dress_003',
        category: 'Women',
        stock: {
          'C98E5D': {'S': 15, 'M': 10},
        },
        price: '1200'),
    Product(
        title: '女士迷你洋裝',
        id: 'women_dress_004',
        category: 'Women',
        stock: {
          'C98E5D': {'S': 15, 'M': 10},
          'E36F10': {'M': 10, 'L': 20},
          '697723': {'M': 0, 'L': 5},
        },
        price: '1200'),
    Product(
        title: '女士迷你洋裝',
        id: 'women_dress_001',
        category: 'Women',
        stock: {
          'C98E5D': {'S': 15, 'M': 10},
          '697723': {'M': 0, 'L': 5},
        },
        price: '1200'),
    Product(
        title: '女士迷你洋裝2',
        id: 'women_dress_002',
        category: 'Women',
        stock: {
          'E36F10': {'S': 15, 'M': 10},
          '697723': {'S': 5, 'M': 0},
        },
        price: '1200'),
    Product(
        title: '經典手錶',
        id: 'watch_001',
        category: 'Access',
        stock: {
          'C98E5D': {'F': 0},
          'E36F10': {'F': 20},
        },
        price: '5000'),
    Product(
        title: '經典手錶2',
        id: 'watch_002',
        category: 'Access',
        stock: {
          'C98E5D': {'F': 50},
        },
        price: '5000'),
  ];

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
                        productVertiListView('Women', products),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('男裝'),
                      children: <Widget>[
                        productVertiListView('Men', products),
                      ],
                    ),
                    ExpansionTile(
                      title: Text('配件'),
                      children: <Widget>[
                        productVertiListView('Access', products),
                      ],
                    ),
                  ],
                ))

              //這是大畫面時的view
              : Row(children: [
                  Expanded(child: categoryVertiListView('Women', products)),
                  Expanded(child: categoryVertiListView('Men', products)),
                  Expanded(child: categoryVertiListView('Access', products)),
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
  Widget productCard(Product product) {
    getHttp();
    return SizedBox(
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
                    decoration: const BoxDecoration(
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
                      children: [
                        Text(product.title),
                        Text('NT\$ ${product.price}')
                      ],
                    ),
                  ))
            ],
          )),
    );
  }

//垂直商品卡片ListView
  Widget productVertiListView(String category, List<Product> products) {
    var filterProducts =
        products.where((product) => product.category == category).toList();

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: filterProducts.length,
      itemBuilder: (context, index) => InkWell(
        child: productCard(filterProducts[index]),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        product: filterProducts[index],
                      )));
        },
      ),
      padding: const EdgeInsets.all(5),
    );
  }

//類別+商品卡ListView
  Widget categoryVertiListView(String category, List<Product> products) {
    var filterProducts =
        products.where((product) => product.category == category).toList();
    String categoryText = category == 'Men'
        ? '男裝'
        : category == 'Women'
            ? '女裝'
            : category == 'Access'
                ? '配件'
                : '';

    return Column(children: [
      Text(categoryText),
      Expanded(
          child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: filterProducts.length,
        itemBuilder: (context, index) => InkWell(
          child: productCard(filterProducts[index]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(product: filterProducts[index])));
          },
        ),
        padding: const EdgeInsets.all(5),
      ))
    ]);
  }
}
