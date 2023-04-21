import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter/detail/detail_bloc.dart';
import 'package:stylish_flutter/detail/detail_page.dart';
import 'package:stylish_flutter/home/home_bloc.dart';
import 'package:stylish_flutter/home/home_event.dart';
import 'package:stylish_flutter/home/home_state.dart';
import 'package:stylish_flutter/models/product.dart';

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
    return BlocProvider<HomeBloc>(
        create: (_) => HomeBloc(Repository())..add(CallApiEvent(Cate.All)),
        child: BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
          if (state is ProductLoadingState) {
            return Center(child: CircularProgressIndicator());
          } else if (state is ProductsErrorState) {
            return Center(child: Text(state.error));
          } else if (state is ProductsLoadedState) {
            return Column(
              children: [
                Expanded(
                  flex: 3,
                  child: topHoriListView(state.hotsProducts),
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
                                productVertiListView(state.womenProducts),
                              ],
                            ),
                            ExpansionTile(
                              title: Text('男裝'),
                              children: <Widget>[
                                productVertiListView(state.menProducts),
                              ],
                            ),
                            ExpansionTile(
                              title: Text('配件'),
                              children: <Widget>[
                                productVertiListView(state.accessProducts),
                              ],
                            ),
                          ],
                        ))

                      //這是大畫面時的view
                      : Row(children: [
                          Expanded(
                              child:
                                  categoryVertiListView(Cate.Women, state.womenProducts)),
                          Expanded(
                              child:
                                  categoryVertiListView(Cate.Men, state.menProducts)),
                          Expanded(
                              child:
                                  categoryVertiListView(Cate.Access, state.accessProducts)),
                        ]),
                )
              ],
            );
          } else {
            return SizedBox.shrink();
          }
        }));
  }

// 上方水平畫面元件區
  Widget topImageCard(Product item) {
    return SizedBox(
      width: 300,
      height: 250,
      child: Card(
        color: Colors.deepOrange,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: CachedNetworkImage(
                    imageUrl: item.mainImage,
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(Radius.circular(20)),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ))),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
      ),
    );
  }

  Widget topHoriListView(List<Product> hots) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: hots.length,
      itemBuilder: (context, index) => topImageCard(hots[index]),
      padding: EdgeInsets.all(5),
    );
  }

//下方畫面元件區
  Widget productCard(Product product) {
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
                  child: CachedNetworkImage(
                    imageUrl: product.mainImage,
                    imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20)
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ))),
                    placeholder: (context, url) =>
                        const CircularProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
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
  Widget productVertiListView(List<Product> products) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: products.length,
      itemBuilder: (context, index) => InkWell(
        child: productCard(products[index]),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DetailPage(
                        product: products[index],
                      )));
        },
      ),
      padding: const EdgeInsets.all(5),
    );
  }

//類別+商品卡ListView
  Widget categoryVertiListView(Cate category, List<Product> products) {
    String categoryStr = '';
    String title = '';
    switch (category) {
      case Cate.All:
        title = '全部商品';
        break;
      case Cate.Women:
        title = '女裝';
        break;
      case Cate.Men:
        title = '男裝';
        break;
      case Cate.Access:
        title = '飾品';
        break;
      default:
        title = '';
        break;
    }

    return Column(children: [
      Text(title),
      Expanded(
          child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: products.length,
        itemBuilder: (context, index) => InkWell(
          child: productCard(products[index]),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailPage(product: products[index])));
          },
        ),
        padding: const EdgeInsets.all(5),
      ))
    ]);
  }
}
