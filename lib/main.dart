import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // title: 'Flutter layout demo',
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
            child: Column(
              children: <Widget>[
                ExpansionTile(
                  title: Text(
                    '女裝',
                  ),
                  children: [
                    SizedBox(
                      height: double.maxFinite,
                      child: productVertiListView(),
                    )
                  ],
                )
              ],
            ))
      ],
    );
  }


  // Column(children: [
            //   Container(child: categoryVertiListView('女裝'),),
            //   Container(child: categoryVertiListView('男裝')),
            //   Container(child: categoryVertiListView('配件')),
            // ],)
            


//     //這是大畫面時的view
            //     Row(children: [
            //   Expanded(child: categoryVertiListView('女裝')),
            //   Expanded(child: categoryVertiListView('男裝')),
            //   Expanded(child: categoryVertiListView('配件')),
            // ]),

            

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

  Widget productVertiListView() {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: 6,
      itemBuilder: (context, index) => productCard(),
      padding: const EdgeInsets.all(5),
    );
  }

  Widget categoryVertiListView(String category) {
    return Column(children: [
      Text(category),
      Expanded(
          child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 6,
        itemBuilder: (context, index) => productCard(),
        padding: const EdgeInsets.all(5),
      ))
    ]);
  }
}
