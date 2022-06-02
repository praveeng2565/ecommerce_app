class ProductDetails {
  ProductDetails(
      {required this.id,
      required this.brandName,
      required this.cost,
      required this.imagePath,
      this.isAddedToCart = false,
      this.description = ''});
  int id;
  String brandName;
  String imagePath;
  double cost;
  bool isAddedToCart;
  String description;
}
