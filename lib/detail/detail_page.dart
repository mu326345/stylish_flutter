import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter/detail/detail_bloc.dart';
import 'package:stylish_flutter/detail/detail_event.dart';
import 'package:stylish_flutter/detail/detail_state.dart';
import 'package:stylish_flutter/pay/pay_page.dart';
import '../models/product.dart';

class DetailPage extends StatefulWidget {
  final Product product;
  const DetailPage({super.key, required this.product});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  final bloc = DetailBloc();

  int sizeSelectedIndex = -1;
  String colorSelect = '';
  int quantity = 1;
  late ValueChanged<int> onChanged;

  late List<String> colorList;
  late List<String> sizeList;

  bool isSmall(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  @override
  void initState() {
    super.initState();
    colorList = <String>[];
    sizeList = <String>[];
    for (var item in widget.product.variants) {
      if (!colorList.contains(item.colorCode)) {
        colorList.add(item.colorCode);
      }
      if (!sizeList.contains(item.size)) {
        sizeList.add(item.size);
      }
    }
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
        body: SingleChildScrollView(
            child: isSmall(context) ? detailAppView() : detailWebView()));
  }

  Widget detailAppView() {
    return Container(
      margin: const EdgeInsets.fromLTRB(40, 30, 40, 30),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CachedNetworkImage(
          width: double.infinity,
          height: 500,
          imageUrl: widget.product.mainImage,
          imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ))),
          placeholder: (context, url) => const CircularProgressIndicator(),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Text(
          widget.product.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(widget.product.id.toString()),
        const SizedBox(
          height: 16,
        ),
        Text('NT\$ ${widget.product.price}'),
        const SizedBox(
          height: 8,
        ),
        const Divider(
          color: Colors.grey,
          thickness: 1,
        ),
        listColorCard(colorList),
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
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PayPage()));
          },
          child: const Text('請選擇尺寸'),
        ),
        const SizedBox(
          height: 16,
        ),
        Text(widget.product.note),
        Text(widget.product.texture),
        Text(widget.product.description),
        Text(widget.product.place),
        Text(widget.product.wash),
        listPhoto(widget.product.images)
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
                  child: CachedNetworkImage(
                    width: double.infinity,
                    height: 500,
                    imageUrl: widget.product.mainImage,
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ))),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
                              Text(
                                widget.product.title,
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 24),
                              ),
                              Text(
                                widget.product.id.toString(),
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                              Text('NT\$ ${widget.product.price}'),
                              const SizedBox(
                                height: 8,
                              ),
                              const Divider(
                                color: Colors.grey,
                                thickness: 1,
                              ),
                              listColorCard(colorList),
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PayPage()));
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
            listPhoto(widget.product.images)
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
    return BlocProvider(
        create: (_) => DetailBloc(),
        child: Row(
          children: [
            const Text('顏色'),
            straightLine(),
            SizedBox(
                height: 30,
                width: 230,
                child: BlocBuilder<DetailBloc, DetailState>(
                  builder: (context, state) {
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: colorList.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => InkWell(
                              onTap: () {
                                context
                                    .read<DetailBloc>()
                                    .add(ColorSelect(index));
                              },
                              //色號方塊
                              child: SizedBox(
                                width: 30,
                                height: 30,
                                child: Card(
                                  shape: state.selectedColorIndex == index
                                      ? const RoundedRectangleBorder(
                                          side: BorderSide(
                                              color: Colors.red, width: 2),
                                          borderRadius: BorderRadius.zero,
                                        )
                                      : const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.zero,
                                        ),
                                  color: Color(
                                      int.parse('0xFF${colorList[index]}')),
                                ),
                              ),
                            ));
                  },
                ))
          ],
        ));
  }

//尺寸按鈕
  Widget listSizeBtn(List<String> sizeList) {
    return SizedBox(
      height: 30,
      width: 230,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: sizeList.length,
          shrinkWrap: true,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              width: 6,
            );
          },
          itemBuilder: (ontext, index) {
            final size = sizeList[index];
            int stock = 0;
            widget.product.variants.forEach((item) {
              if (item.colorCode == colorSelect) {
                stock = item.stock;
              } else {
                stock = 0;
              }
            });

            if (colorSelect == '') {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(size),
                onPressed: () => {},
              );
            } else if (stock > 0) {
              return ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: sizeSelectedIndex == index
                      ? Colors.grey[400]
                      : Colors.grey[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text(size),
                onPressed: () {
                  setState(() {
                    sizeSelectedIndex = index;
                  });
                },
              );
            } else {
              return Stack(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.grey[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    onPressed: null,
                    child: Text(size),
                  ),
                  const Positioned(
                    top: 30 / 2 - 8,
                    left: 60 / 2 - 8,
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        'X',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              );
            }
          }),
    );
  }

//數量按鈕
  Widget quantityButton({required Null Function(int value) onChanged}) {
    return SizedBox(
      width: 230,
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

//網頁下方畫面
Widget listPhoto(List<String> images) {
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
        //TODO: ListView 在滑動的時候會有UI卡頓問題待解決
        ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          shrinkWrap: true,
          // ignore: prefer_const_constructors
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: SizedBox(
              height: 500,
              child: CachedNetworkImage(
                width: double.infinity,
                height: 500,
                imageUrl: images[index],
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  )),
                ),
                placeholder: (context, url) =>
                    const CircularProgressIndicator(),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
