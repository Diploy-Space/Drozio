import 'package:flutter_test/flutter_test.dart';
import 'package:rozio/providers/reel_provider.dart';

void main() {
  group('ReelProvider Tests', () {
    late ReelProvider reelProvider;

    setUp(() {
      reelProvider = ReelProvider();
    });

    test('Initial tab is forYou', () {
      expect(reelProvider.activeTab, ReelTab.forYou);
      expect(reelProvider.reels.isNotEmpty, isTrue);
    });

    test('Switching tabs updates activeTab', () {
      reelProvider.setTab(ReelTab.following);
      expect(reelProvider.activeTab, ReelTab.following);

      reelProvider.setTab(ReelTab.live);
      expect(reelProvider.activeTab, ReelTab.live);
    });

    test('Toggling like updates isLiked and likesCount', () {
      final reel = reelProvider.reels.first;
      final initialLikes = reel.likesCount;
      final initialLiked = reel.isLiked;

      reelProvider.toggleLike(reel.id);
      expect(reel.isLiked, !initialLiked);
      expect(reel.likesCount, initialLiked ? initialLikes - 1 : initialLikes + 1);
    });

    test('Toggling save and follow updates state', () {
      final reel = reelProvider.reels.first;
      final initialSaved = reel.isSaved;
      final initialFollowing = reel.isFollowing;

      reelProvider.toggleSave(reel.id);
      expect(reel.isSaved, !initialSaved);

      reelProvider.toggleFollow(reel.id);
      expect(reel.isFollowing, !initialFollowing);
    });
  });
}
