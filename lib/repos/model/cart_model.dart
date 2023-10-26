class CartModel {
  final String cartName;
  final String cartImage;
  final int cartPrice;
  final String cartSize;
  final int cartColor;
  final String cartId;
  int cartQuantity = 1;

  CartModel({
    required this.cartColor,
    required this.cartImage,
    required this.cartName,
    required this.cartPrice,
    required this.cartSize,
    required this.cartId,
    required this.cartQuantity,
  });
}
