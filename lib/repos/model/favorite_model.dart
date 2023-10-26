
class FavoriteModel {
  final String favoriteName;
  final List<dynamic> favoriteImage;
  final int favoritePrice;
  final int favoriteRate;
  final String favoriteId;
  final List<dynamic> favoriteSize;
  final String productDescription;
  final int favoriteColor;
  int favoriteQuantity = 1;

  FavoriteModel({
    required this.productDescription,
    required this.favoriteColor,
    required this.favoriteImage,
    required this.favoriteId,
    required this.favoriteName,
    required this.favoriteRate,
    required this.favoritePrice,
    required this.favoriteSize,
    required this.favoriteQuantity,
  });

}
