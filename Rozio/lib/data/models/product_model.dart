class ProductModel {
  final String id;
  final String title;
  final String storeName;
  final bool isStoreVerified;
  final double rating;
  final int reviewsCount;
  final double price;
  final double originalPrice;
  final String deliveryDateText;
  final String deliveryLocation;
  final bool codAvailable;
  final String imageUrl;
  final List<String> availableColors;
  final List<String> availableEditions;
  final String storePositiveRating;
  final String storeShippingSpeed;

  const ProductModel({
    required this.id,
    required this.title,
    required this.storeName,
    this.isStoreVerified = true,
    this.rating = 4.7,
    this.reviewsCount = 312,
    required this.price,
    required this.originalPrice,
    this.deliveryDateText = 'Free delivery by Thu, Oct 29',
    this.deliveryLocation = 'To Andheri West 400053',
    this.codAvailable = true,
    required this.imageUrl,
    this.availableColors = const ['Ivory', 'Black', 'Blue'],
    this.availableEditions = const ['Standard', 'Pro', 'Pro Max'],
    this.storePositiveRating = '98% positive',
    this.storeShippingSpeed = 'Ships in 24h',
  });

  double get discountPercent =>
      originalPrice > price ? (((originalPrice - price) / originalPrice) * 100).roundToDouble() : 0.0;
}
