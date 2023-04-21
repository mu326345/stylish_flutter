import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:stylish_flutter/detail/detail_bloc.dart';
import 'package:stylish_flutter/home/home_event.dart';
import 'package:stylish_flutter/home/home_state.dart';
import 'package:stylish_flutter/models/product.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final Repository repository;

  HomeBloc(this.repository) : super(ProductLoadingState()) {
    on<CallApiEvent>((event, emit) async {
      emit(ProductLoadingState());
      try {
        final womenResponse = await repository.getProducts(Cate.Women);
        final menResponse = await repository.getProducts(Cate.Men);
        final accessResponse = await repository.getProducts(Cate.Access);
        final hotsResponse = await repository.getProducts(Cate.Hots);
        emit(ProductsLoadedState(womenResponse, menResponse, accessResponse, hotsResponse));
      } catch (e, stacktrace) {
        print(stacktrace);
        emit(ProductsErrorState(e.toString()));
      }
    },);
  }
}

class Repository {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.appworks-school.tw/api/1.0/',
      responseType: ResponseType.json))
    ..interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        return handler.next(options);
      },
      onResponse: (response, handler) {
        return handler.next(response);
      },
      onError: (error, handler) {
        return handler.next(error);
      },
    ));

  List<Product> products = [];

   Future<List<Product>> getProducts(Cate category) async {
    String categoryStr = '';
    switch(category) {
      case Cate.All: 
      categoryStr = 'products/all'; break;
      case Cate.Women: 
      categoryStr = 'products/women'; break;
      case Cate.Men: 
      categoryStr = 'products/men'; break;
      case Cate.Access: 
      categoryStr = 'products/accessories'; break;
      case Cate.Hots: 
      categoryStr = 'marketing/hots'; break;
      default: 
      categoryStr = ''; break;
    }

    final response = await dio.get(categoryStr);

    if (response.statusCode == 200) {
      dynamic responseData = response.data['data'];

      // 判斷回傳資料是hots 還是其他 
      if (responseData is List) {
        var isHots = responseData[0]['products'] != null;
        if (isHots) { 
          responseData = responseData[0]['products'];
        }
      }
      
      final List<Product> productsparseData =
          responseData.map<Product>((json) => Product.fromJson(json)).toList();
      return productsparseData;
    } else {
      throw Exception('Failed to load products');
    }
   }
}

 enum Cate {
  All,
  Women,
  Men,
  Access,
  Hots
}
