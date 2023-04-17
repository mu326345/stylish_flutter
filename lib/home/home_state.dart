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
  ProductsLoadedState(this.products);
  final List<Product> products;
  
  @override
  List<Object?> get props => [products];
}

class ProductsErrorState extends HomeState {
  ProductsErrorState(this.error);
  final String error;

  @override
  List<Object?> get props => [error];
}