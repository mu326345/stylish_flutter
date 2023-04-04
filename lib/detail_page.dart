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

  int selectedIndex = -1;
  int quantity = 1;
  late ValueChanged<int> onChanged;

  bool isSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
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
          backgroundColor: const Color(0xFFEEF1F7),
        ),
        body: SingleChildScrollView(
          child: isSmall(context) ? detailAppView() : detailWebView()
        ));
  }

  Widget detailAppView() {
    return Container(
      margin: const EdgeInsets.fromLTRB(70, 40, 70, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Container(
          color: Colors.blue,
          width: double.infinity,
          height: 500,
        ),
        const Text(
          '商品名稱',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        const Text('貨號'),
        const SizedBox(
          height: 16,
        ),
        const Text('NT\$343'),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        Row(
          children: [
            const Text('顏色'),
            straightLine(),
            listColorCard(colorList)
          ],
        ),
        Row(
          children: [const Text('尺寸'), straightLine(), listSizeBtn(sizeList)],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: [
            const Text('數量'),
            straightLine(),
            quantityButton(
              onChanged: (int value) {
                1;
              },
            ),
          ],
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: Colors.grey[800],
            shape:
                const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            minimumSize: const Size(350, 60),
          ),
          onPressed: () {
            // TODO: Add onPressed action
          },
          child: const Text('請選擇尺寸'),
        ),
        const SizedBox(
          height: 16,
        ),
        const Text('實品顏色依單品照為主'),
        const Text('棉100%'),
        const Text('厚薄：薄'),
        const Text('彈性：無'),
        const Text('素材產地/日本'),
        const Text('加工產地/日本'),
        listPhoto()
      ]),
    );
  }

  Widget detailWebView() {
    return Container(
        margin: const EdgeInsets.fromLTRB(80, 40, 80, 40),
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
                        margin: const EdgeInsets.only(left: 16),
                        child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '商品名稱',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              const Text('貨號'),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text('NT\$343'),
                              const SizedBox(
                                height: 8,
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              Row(
                                children: [
                                  const Text('顏色'),
                                  straightLine(),
                                  listColorCard(colorList)
                                ],
                              ),
                              Row(
                                children: [
                                  const Text('尺寸'),
                                  straightLine(),
                                  listSizeBtn(sizeList)
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Row(
                                children: [
                                  const Text('數量'),
                                  straightLine(),
                                  quantityButton(
                                    onChanged: (int value) {
                                      1;
                                    },
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[800],
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.zero),
                                  minimumSize: const Size(350, 60),
                                ),
                                onPressed: () {
                                  // TODO: Add onPressed action
                                },
                                child: const Text('請選擇尺寸'),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              const Text('實品顏色依單品照為主'),
                              const Text('棉100%'),
                              const Text('厚薄：薄'),
                              const Text('彈性：無'),
                              const Text('素材產地/日本'),
                              const Text('加工產地/日本'),
                            ],
                          ),
                        )))
              ],
            ),
            //下半段的文字及照片
            listPhoto()
          ],
        ));
  }

//水平直線
  Widget straightLine() {
    return const SizedBox(
      height: 20,
      width: 50,
      child: VerticalDivider(
        color: Colors.grey,
        thickness: 1,
      ),
    );
  }

//色卡選項
  Widget listColorCard(List<String> colorList) {
    return SizedBox(
      height: 30,
      width: 250,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: colorList.length,
          shrinkWrap: true,
          itemBuilder: (context, index) => InkWell(
                onTap: () {
                  setState(() {});
                },
                child: SizedBox(
                  width: 30,
                  height: 30,
                  child: Card(
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    color: Color(int.parse('0xFF${colorList[index]}')),
                  ),
                ),
              )),
    );
  }

//網頁下方畫面
  Widget listPhoto() {
    Shader linearGradient = const LinearGradient(
      colors: <Color>[Color.fromARGB(255, 0, 110, 254), Colors.green],
    ).createShader(const Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

    return SizedBox(
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
             const Expanded(
                child: Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
              )
            ],
          ),
          const Text(
            'O.N.S is all about options, which is why we took our staple polo shirt and upgraded it with slubby linen jersey, making it even lighter for those who perfer their summer style extra-breezy.',
            softWrap: true,
          ),
          const SizedBox(
            height: 16,
          ),
          ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: 5,
              shrinkWrap: true,
              // ignore: prefer_const_constructors
              itemBuilder: (context, index) => SizedBox(
                    width: double.infinity,
                    height: 500,
                    child: const Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                      color: Colors.blue,
                    ),
                  )),
        ],
      ),
    );
  }

//尺寸按鈕
  Widget listSizeBtn(List<String> sizeList) {
    return SizedBox(
      height: 30,
      width: 250,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: sizeList.length,
        shrinkWrap: true,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 6,
          );
        },
        itemBuilder: (context, index) => ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary:
                selectedIndex == index ? Colors.grey[400] : Colors.grey[700],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // 設置圓角半徑
            ),
          ),
          child: Text(sizeList[index]),
          onPressed: () {
            setState(() {
              selectedIndex = index;
            });
          },
        ),
      ),
    );
  }

//數量按鈕
  Widget quantityButton({required Null Function(int value) onChanged}) {
    return SizedBox(
      width: 250,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          IconButton(
            icon: const Icon(Icons.remove_circle),
            onPressed: () {
              if (quantity > 1) {
                setState(() {
                  quantity--;
                  onChanged(quantity);
                });
              }
            },
          ),
          Text('$quantity'),
          IconButton(
            icon: const Icon(Icons.add_circle),
            onPressed: () {
              setState(() {
                quantity++;
                onChanged(quantity);
              });
            },
          ),
        ],
      ),
    );
  }
}
