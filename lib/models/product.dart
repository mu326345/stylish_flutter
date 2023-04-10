class Product {
  final String title;
  final String id;
  final String category;
  final Map<String, Map<String, int>> stock; // 使用 Map 來記錄每種顏色、尺寸的庫存
  final String price;

  Product(
      {required this.title,
      required this.id,
      required this.category,
      required this.stock,
      required this.price});
}
