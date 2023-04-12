import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_flutter/detail_page/detail_event.dart';
import 'package:stylish_flutter/detail_page/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  DetailBloc() : super(const DetailState()) {
    on<ColorSelect>((event, emit) {
      emit(state.copyWith(selectedColorIndex: event.index));
    });

    on<SizeSelect>((event, emit) {
      emit(state.copyWith(selectedSizeIndex: event.index));
    });

    on<CountIncreasePressed>(((event, emit) {
      emit(state.copyWith(count: state.count + 1));
    }));

    on<CountDecreasePressed>(((event, emit) {
      emit(state.copyWith(count: state.count - 1));
    }));
  }
}
