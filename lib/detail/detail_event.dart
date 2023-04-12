abstract class DetailEvent {}

class ColorSelect extends DetailEvent {
  final int index;
  ColorSelect(this.index);
}

class SizeSelect extends DetailEvent {
  final int index;
  SizeSelect(this.index);
}

//增加數量
class CountIncreasePressed extends DetailEvent {
  final int count;
  CountIncreasePressed(this.count);
}

//減少數量
class CountDecreasePressed extends DetailEvent {
  final int count;
  CountDecreasePressed(this.count);
}
