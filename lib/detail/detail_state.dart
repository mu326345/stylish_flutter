class DetailState {
  final int selectedColorIndex;
  final int selectedSizeIndex;
  final int count;

//預設index
  const DetailState({
    this.selectedColorIndex = -1,
    this.selectedSizeIndex = -1,
    this.count = 0,
  });

//copyWith 避免對原本狀態進行修改，使用copyWith複製並返回新的狀態對象
  DetailState copyWith({
    int? selectedColorIndex,
    int? selectedSizeIndex,
    int? count,
  }) {
    return DetailState(
      selectedColorIndex: selectedColorIndex ?? this.selectedColorIndex,
      selectedSizeIndex: selectedSizeIndex ?? this.selectedSizeIndex,
      count: count ?? this.count,
    );
  }
}
