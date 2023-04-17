import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:stylish_flutter/home/home_bloc.dart';
import 'package:stylish_flutter/home/home_state.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();
}

class CallApiEvent extends HomeEvent {
  CallApiEvent(this.category);
  final Cate category;
  
  @override
  List<Object> get props => [category];
}