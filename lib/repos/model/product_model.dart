
class ProductModel {
  final String productName;
  final List<dynamic> productImages;
  final List<dynamic> productSizes;
  final List<dynamic> productColors;
  final String productId;
  final String productCategory;
  final String productDescription;
  final int productRate;
  final int productPrice;

  ProductModel({
    required this.productCategory,
    required this.productColors,
    required this.productDescription,
    required this.productId,
    required this.productImages,
    required this.productName,
    required this.productPrice,
    required this.productRate,
    required this.productSizes,
  });

  factory ProductModel.fromJson(json) => ProductModel(
        productCategory: json["productCategory"],
        productColors: json["productColors"],
        productDescription: json["productDescription"],
        productId: json["productId"],
        productImages: json["productImages"],
        productName: json["productName"],
        productPrice: json["productPrice"],
        productRate: json["productLikes"],
        productSizes: json["productSizes"],
      );

 
}
