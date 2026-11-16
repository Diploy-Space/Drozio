import 'product_model.dart';

class ReelModel {
  final String id;
  final String videoThumbnail;
  final String storeName;
  final String storeAvatar;
  final bool isStoreVerified;
  final String caption;
  final String audioTitle;
  int likesCount;
  final int commentsCount;
  bool isLiked;
  bool isSaved;
  bool isFollowing;
  final ProductModel product;
  final double hotspotXPercent;
  final double hotspotYPercent;

  ReelModel({
    required this.id,
    required this.videoThumbnail,
    required this.storeName,
    required this.storeAvatar,
    this.isStoreVerified = true,
    required this.caption,
    required this.audioTitle,
    required this.likesCount,
    required this.commentsCount,
    this.isLiked = false,
    this.isSaved = false,
    this.isFollowing = false,
    required this.product,
    this.hotspotXPercent = 0.58,
    this.hotspotYPercent = 0.49,
  });
}
