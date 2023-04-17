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
        final product = await repository.getProducts(Cate.All);
        emit(ProductsLoadedState(product));
      } catch (e) {
        emit(ProductsErrorState(e.toString()));
      }
    },);
  }
}

class Repository {
  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.appworks-school.tw/api/1.0/products/',
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
      categoryStr = 'all'; break;
      case Cate.Women: 
      categoryStr = 'women'; break;
      case Cate.Men: 
      categoryStr = 'men'; break;
      case Cate.Access: 
      categoryStr = 'accessories'; break;
      default: 
      categoryStr = ''; break;
    }

    final response = await dio.get(categoryStr);
    final responsePage = response.data['next_paging']; //TODO: 要下載全部頁面

    if (response.statusCode == 200) {
      final responseData = response.data['data'];
      
      print(responsePage);
      final List<Product> productsparseData = responseData.map<Product>((json) => 
        Product.fromJson(json)).toList();
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
}
