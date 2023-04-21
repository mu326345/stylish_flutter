class Product {
  final int id;
  final String category;
  final String title;
  final String description;
  final int price;
  final String texture;
  final String wash;
  final String place;
  final String note;
  final String story;
  final List<ItemColor> colors;
  final List<String> sizes;
  final List<Variant> variants;
  final String mainImage;
  final List<String> images;

  Product({
    required this.id,
    required this.category,
    required this.title,
    required this.description,
    required this.price,
    required this.texture,
    required this.wash,
    required this.place,
    required this.note,
    required this.story,
    required this.colors,
    required this.sizes,
    required this.variants,
    required this.mainImage,
    required this.images,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    final List<dynamic> colorsJson = json['colors'];//取出Json中colors的值 //dynamic:動態的、變量的
    final List<ItemColor> colors = colorsJson//由dynamic轉換成Color類型
    .map((colorsJson) => ItemColor.fromJson(colorsJson))//將每一個colorsJson物件轉換成Color物件，集結成一個List
    .toList();

    final List<dynamic> variantsJson = json['variants'];
    final List<Variant> variants = variantsJson
    .map((variantsJson) => Variant.fromJson(variantsJson))
    .toList();

    final List<dynamic> imagesJson = json['images'];
    final List<String> images = imagesJson
    .map((imagesJson) => imagesJson.toString()).toList();

    return Product(
      id: json['id'], 
      category: json['category'],
      title: json['title'], 
      description: json['description'], 
      price: json['price'],
      texture: json['texture'],
      wash: json['wash'], 
      place: json['place'], 
      note: json['note'], 
      story: json['story'], 
      colors: colors, 
      sizes: json['sizes']?.cast<String>(), 
      variants: variants, 
      mainImage: json['main_image'].toString(), 
      images: images);
  }
}

class ItemColor {
  final String code;
  final String name;

  ItemColor({
    required this.code,
    required this.name,
  });

  factory ItemColor.fromJson(Map<String, dynamic> json) {
    return ItemColor(
      code: json['code'],
      name: json['name'],
    );
  }
}

class Variant {
  final String colorCode;
  final String size;
  final int stock;

  Variant({
    required this.colorCode,
    required this.size,
    required this.stock,
  });

  factory Variant.fromJson(Map<String, dynamic> json) {
    return Variant(
      colorCode: json['color_code'],
      size: json['size'],
      stock: json['stock'],
    );
  }
}