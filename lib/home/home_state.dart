import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/models/product.dart';

@immutable
abstract class HomeState extends Equatable {}

class ProductLoadingState extends HomeState {
  @override
  List<Object> get props => [];
}

class ProductsLoadedState extends HomeState {
  ProductsLoadedState(
    this.womenProducts,
    this.menProducts,
    this.accessProducts,
    this.hotsProducts,
  );
  final List<Product> womenProducts;
  final List<Product> menProducts;
  final List<Product> accessProducts;
  final List<Product> hotsProducts;

  
  @override
  List<Object?> get props => [womenProducts, menProducts, accessProducts, hotsProducts];
}

class ProductsErrorState extends HomeState {
  ProductsErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}