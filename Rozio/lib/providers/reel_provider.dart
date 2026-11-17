import 'package:flutter/material.dart';
import '../data/models/product_model.dart';
import '../data/models/reel_model.dart';

enum ReelTab { following, forYou, live }

class ReelProvider extends ChangeNotifier {
  ReelTab _activeTab = ReelTab.forYou;
  int _currentReelIndex = 0;

  ReelTab get activeTab => _activeTab;
  ReelTab get currentTab => _activeTab;
  int get currentReelIndex => _currentReelIndex;
  int get activeReelIndex => _currentReelIndex;

  void setTab(ReelTab tab) {
    _activeTab = tab;
    notifyListeners();
  }

  final List<ReelModel> _reels = [
    ReelModel(
      id: 'reel_1',
      videoThumbnail: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=800&auto=format&fit=crop',
      storeName: 'Glow Audio',
      storeAvatar: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=200&auto=format&fit=crop',
      caption: 'Noise cancelling that holds up on the metro. Battery test at the end.',
      audioTitle: 'Original audio · Glow Audio',
      likesCount: 3200,
      commentsCount: 184,
      isLiked: false,
      isSaved: false,
      isFollowing: false,
      product: const ProductModel(
        id: 'prod_earbuds_anc',
        title: 'Pro Wireless Earbuds ANC',
        storeName: 'Glow Audio',
        price: 59.0,
        originalPrice: 79.0,
        imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400&auto=format&fit=crop',
        availableColors: ['Ivory', 'Black', 'Blue'],
        availableEditions: ['Standard', 'Pro', 'Pro Max'],
      ),
    ),
    ReelModel(
      id: 'reel_2',
      videoThumbnail: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=800&auto=format&fit=crop',
      storeName: 'Urban Tech Co',
      storeAvatar: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=200&auto=format&fit=crop',
      caption: 'Smartwatch series X with AMOLED display & 7-day battery life.',
      audioTitle: 'Trendy Beats · Urban Beats',
      likesCount: 1540,
      commentsCount: 92,
      isLiked: true,
      isSaved: true,
      isFollowing: true,
      product: const ProductModel(
        id: 'prod_smartwatch',
        title: 'Nova AMOLED Smartwatch',
        storeName: 'Urban Tech Co',
        price: 89.0,
        originalPrice: 129.0,
        imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400&auto=format&fit=crop',
        availableColors: ['Space Grey', 'Rose Gold', 'Midnight'],
        availableEditions: ['GPS 40mm', 'GPS 44mm', 'Cellular'],
      ),
    ),
  ];

  List<ReelModel> get reels => List.unmodifiable(_reels);

  ReelModel? get currentReel =>
      _reels.isNotEmpty && _currentReelIndex < _reels.length ? _reels[_currentReelIndex] : null;

  void setReelIndex(int index) {
    if (index >= 0 && index < _reels.length) {
      _currentReelIndex = index;
      notifyListeners();
    }
  }

  void toggleLike(String reelId) {
    final index = _reels.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      _reels[index].isLiked = !_reels[index].isLiked;
      if (_reels[index].isLiked) {
        _reels[index].likesCount += 1;
      } else {
        _reels[index].likesCount -= 1;
      }
      notifyListeners();
    }
  }

  void toggleSave(String reelId) {
    final index = _reels.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      _reels[index].isSaved = !_reels[index].isSaved;
      notifyListeners();
    }
  }

  void toggleFollow(String reelId) {
    final index = _reels.indexWhere((r) => r.id == reelId);
    if (index != -1) {
      _reels[index].isFollowing = !_reels[index].isFollowing;
      notifyListeners();
    }
  }
}
