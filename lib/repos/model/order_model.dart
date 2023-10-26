class OrderModel {
  final String orderName;
  final String orderImage;
  final double orderPrice;
  final String addressId;
  final String orderSize;
  final int orderColor;
  final String orderId;
  final int orderQuantity;
  final String userId;

  OrderModel({
    required this.orderColor,
    required this.orderImage,
    required this.addressId,
    required this.userId,
    required this.orderName,
    required this.orderPrice,
    required this.orderSize,
    required this.orderId,
    required this.orderQuantity,
  });
  factory OrderModel.fromJson(var item) {
    return OrderModel(
      orderImage: item["orderImage"],
      userId: item["userId"],
      orderColor: item["orderColor"],
      orderName: item["orderName"],
      addressId: item["addressId"],
      orderQuantity: item["orderQuantity"],
      orderSize: item["orderSize"],
      orderId: item["orderId"],
      orderPrice: item["orderPrice"],
    );
  }
}
