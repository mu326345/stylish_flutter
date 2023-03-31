import 'package:flutter/material.dart';

class DetailPage extends StatefulWidget {
  final String title;
  const DetailPage({super.key, required this.title});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> colorList = ['697723', 'E36F10', 'C98E5D'];
  List<String> sizeList = ['S', 'M', "L"];

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
          child: Container(
              margin: EdgeInsets.fromLTRB(80, 40, 80, 40),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          color: Colors.blue,
                          width: double.infinity,
                          height: 500,
                        ),
                      ),
                      Expanded(
                          child: Container(
                              height: 500,
                              width: double.infinity,
                              margin: EdgeInsets.only(left: 16),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '商品名稱',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 24),
                                    ),
                                    Text('貨號'),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text('NT\$343'),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                      thickness: 1,
                                    ),
                                    Row(
                                      children: [
                                        Text('顏色'),
                                        straightLine(),
                                        listColorCard(colorList)
                                        // Container(height: 30, width: double.infinity, child: listColorCard(colorList),)
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text('尺寸'),
                                        straightLine(),
                                        ListSizeBtn(sizeList)
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Row(
                                      children: [
                                        Text('數量'),
                                        straightLine(),
                                        QuantityButton(
                                          onChanged: (int value) {
                                            1;
                                          },
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.grey[800],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.zero),
                                        minimumSize: Size(350, 60),
                                      ),
                                      onPressed: () {
                                        // TODO: Add onPressed action
                                      },
                                      child: Text('請選擇尺寸'),
                                    ),
                                    SizedBox(
                                      height: 16,
                                    ),
                                    Text('實品顏色依單品照為主'),
                                    Text('棉100%'),
                                    Text('厚薄：薄'),
                                    Text('彈性：無'),
                                    Text('素材產地/日本'),
                                    Text('加工產地/日本'),
                                  ],
                                ),
                              )))
                    ],
                  ),
                  //下半段的文字及照片
                  listPhoto()
                ],
              )),
        ));
  }

  Widget straightLine() {
    return Container(
      height: 20,
      width: 50,
      child: const VerticalDivider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }

  Widget listColorCard(List<String> colorList) {
    return SizedBox(
      height: 30,
      width: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colorList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => SizedBox(
                width: 30,
                height: 30,
                child: Card(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  color: Color(int.parse('0xFF${colorList[index]}')),
                ),
              )),
    );
  }

  Widget listPhoto() {
    Shader linearGradient = const LinearGradient(
      colors: <Color>[Color.fromARGB(255, 0, 110, 254), Colors.green],
    ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return Container(
      width: double.infinity,
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
                Text(
                  '細部說明',
                  style: TextStyle(
                    foreground: Paint()..shader = linearGradient,
                  ),
                ),
              Container(
                width: 850,
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              )
            ],
          ),
          Container(
            child: Text(
              'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who perfer their summer style extra-breezy.',
               softWrap: true,
            ),
          ),
          SizedBox(height: 16,),
          ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, index) => SizedBox(
                width: double.infinity,
                height: 500,
                child: Card(
                  shape:
                      RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  color: Colors.blue,
                ),
              )),
        ],
      ),
    );
  }
}

class ListSizeBtn extends StatefulWidget {
  final List<String> sizeList;

  ListSizeBtn(this.sizeList, {Key? key}) : super(key: key);

  @override
  _ListSizeBtnState createState() => _ListSizeBtnState();
}

class _ListSizeBtnState extends State<ListSizeBtn> {
  int _selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      width: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: widget.sizeList.length,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 6,
          );
        },
        itemBuilder: (context, index) => ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary:
                _selectedIndex == index ? Colors.grey[400] : Colors.grey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // 設置圓角半徑
            ),
          ),
          child: Text(widget.sizeList[index]),
          onPressed: () {
            setState(() {
              _selectedIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class QuantityButton extends StatefulWidget {
  final int quantity;
  final ValueChanged<int> onChanged;

  QuantityButton({Key? key, this.quantity = 1, required this.onChanged})
      : super(key: key);

  @override
  _QuantityButtonState createState() => _QuantityButtonState();
}

class _QuantityButtonState extends State<QuantityButton> {
  late int _quantity;

  @override
  void initState() {
    super.initState();
    _quantity = widget.quantity;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.remove_circle),
            onPressed: () {
              if (_quantity > 1) {
                setState(() {
                  _quantity--;
                  widget.onChanged(_quantity);
                });
              }
            },
          ),
          Text('$_quantity'),
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: () {
              setState(() {
                _quantity++;
                widget.onChanged(_quantity);
              });
            },
          ),
        ],
      ),
    );
  }
}
