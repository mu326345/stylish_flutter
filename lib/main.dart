import 'package:flutter/material.dart'
    show
        AppBar,
        AspectRatio,
        Axis,
        BorderRadius,
        BoxFit,
        BuildContext,
        Card,
        ClipRRect,
        Color,
        Colors,
        Column,
        Container,
        EdgeInsets,
        Expanded,
        Image,
        ListView,
        MaterialApp,
        MediaQuery,
        NeverScrollableScrollPhysics,
        Padding,
        RoundedRectangleBorder,
        Scaffold,
        ScrollPhysics,
        SingleChildScrollView,
        SizedBox,
        StatelessWidget,
        Text,
        Widget,
        runApp;
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/framework.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter layout demo',
      home: Scaffold(
          appBar: AppBar(
            title: Image.asset(
              'images/Image_Logo02.png',
              fit: BoxFit.fitHeight,
              height: 20,
            ),
            backgroundColor: Color(0xFFEEF1F7),
          ),
          body: HomePage()),
    );
  }
}

class BuildCard extends StatelessWidget {
  const BuildCard({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      padding: EdgeInsets.all(8),
      child: Card(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}

class BuildCard1 extends StatelessWidget {
  const BuildCard1({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      height: 250,
      padding: EdgeInsets.all(8),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: 120,
              height: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
                color: Colors.deepOrange,
              ),
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'UNIQLO IS GOOD',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'NT\$ 343',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ],
            ))
          ],
        ),
      ),
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
    var buildCard = BuildCard();
    return Container(
        child: Column(
      children: [
        Expanded(
          flex: 4,
          child: ListView.separated(
            padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
            scrollDirection: Axis.horizontal,
            itemCount: 6,
            separatorBuilder: (context, _) => SizedBox(
              width: 20,
            ),
            itemBuilder: (context, index) => buildCard,
          ),
        ),
        Expanded(
          flex: 6,
          child: isSmall(context)
              ? SingleChildScrollView(
                  physics: ScrollPhysics(),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: Column(
                      children: <Widget>[
                        buildColumn('女裝'),
                        buildColumn('男裝'),
                        buildColumn('配件'),
                      ],
                    ),
                  ),
                )
              : Row(
                  children: [
                    buildColumn('女裝'),
                    buildColumn('男裝'),
                    buildColumn('配件'),
                  ],
                ),
        )
      ],
    ));
  }

  Widget buildListView() {
    var buildCard = BuildCard();
    return ListView.separated(
      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
      scrollDirection: Axis.horizontal,
      itemCount: 6,
      separatorBuilder: (context, _) => SizedBox(
        width: 20,
      ),
      itemBuilder: (context, index) => buildCard,
    );
  }

  Widget buildColumn(String title) {
    var buildCar1 = BuildCard1();
    return Expanded(
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          SizedBox(height: 10),
          Expanded(
              child: SingleChildScrollView(
            child: ListView.separated(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) => buildCar1,
              separatorBuilder: (context, _) => SizedBox(
                height: 20,
              ),
              itemCount: 6,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
            ),
          )),
        ],
      ),
    );
  }
}
