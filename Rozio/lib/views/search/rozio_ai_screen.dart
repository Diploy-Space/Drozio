import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../product/product_detail_sheet.dart';
import 'photo_search_screen.dart';
import 'voice_search_sheet.dart';

class RozioAiScreen extends StatefulWidget {
  const RozioAiScreen({super.key});

  @override
  State<RozioAiScreen> createState() => _RozioAiScreenState();
}

class _RozioAiScreenState extends State<RozioAiScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _hasStartedChat = false;

  final List<Map<String, dynamic>> _messages = [];

  final List<Map<String, String>> _starterPrompts = [
    {
      'title': 'A gift for my sister under \$250',
      'category': 'Gifts',
      'query': 'A gift for my sister under \$250. She likes jewellery and watches.',
    },
    {
      'title': 'Earbuds with good noise cancelling',
      'category': 'Audio',
      'query': 'Show me the best wireless earbuds with active noise cancellation under \$100.',
    },
    {
      'title': 'Something for my desk under \$50',
      'category': 'Work from home',
      'query': 'What are some great productivity and desk setup essentials under \$50?',
    },
    {
      'title': 'What is on sale in home decor?',
      'category': 'Deals',
      'query': 'Show me trending home decor and planters with highest discounts.',
    },
  ];

  static const List<ProductModel> _aiRecommendedProducts = [
    ProductModel(
      id: 'ai_prod_1',
      title: 'Sterling Silver Solitaire Ring',
      storeName: 'Rozio Store',
      price: 220,
      originalPrice: 260,
      imageUrl: 'https://images.unsplash.com/photo-1605100804763-247f67b3557e?w=500&auto=format&fit=crop',
      rating: 4.8,
      reviewsCount: 42,
    ),
    ProductModel(
      id: 'ai_prod_2',
      title: 'Sport Smart Watch, Ocean Band',
      storeName: 'Global Tech',
      price: 89,
      originalPrice: 110,
      imageUrl: 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=500&auto=format&fit=crop',
      rating: 4.6,
      reviewsCount: 88,
    ),
    ProductModel(
      id: 'ai_prod_3',
      title: 'Copper Alloy Inlaid Zircon Round Ring',
      storeName: 'Rozio Store',
      price: 9,
      originalPrice: 15,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=500&auto=format&fit=crop',
      rating: 4.7,
      reviewsCount: 86,
    ),
  ];

  void _sendQuery(String query) {
    if (query.trim().isEmpty) return;
    setState(() {
      _hasStartedChat = true;
      _messages.add({
        'isUser': true,
        'text': query,
      });
      _messages.add({
        'isUser': false,
        'text': 'Here are three she might love. All of them arrive by Thu, Oct 29 at Andheri West and come gift-ready.',
        'products': _aiRecommendedProducts,
        'followUps': ['Compare these', 'Show only rings', 'Something under \$50', 'Add gift wrap'],
      });
      _textController.clear();
    });

    Future.delayed(const Duration(milliseconds: 200), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _showPastChatsSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        final pastChats = [
          {'title': 'Gift ideas under \$250', 'time': 'Yesterday · 4 items viewed'},
          {'title': 'Best wireless ANC earbuds', 'time': '3 days ago · 2 items bought'},
          {'title': 'Home decor ceramic planters', 'time': 'Oct 20 · 1 item saved'},
        ];

        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Past chats',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close_rounded),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...pastChats.map((chat) => ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.chat_bubble_outline_rounded, color: AppColors.primary, size: 20),
                  ),
                  title: Text(
                    chat['title']!,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  subtitle: Text(
                    chat['time']!,
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                  onTap: () {
                    Navigator.pop(context);
                    _sendQuery(chat['title']!);
                  },
                )),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [AppColors.primary, Color(0xFF8B5CF6)],
                ),
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.auto_awesome_rounded, color: Colors.white, size: 18),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Rozio AI',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: Color(0xFF10B981),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      'Searching 1,240 stores',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        actions: [
          TextButton.icon(
            onPressed: _showPastChatsSheet,
            icon: const Icon(Icons.history_rounded, size: 18, color: AppColors.textSecondary),
            label: const Text(
              'Past chats',
              style: TextStyle(
                color: AppColors.textSecondary,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          // Chat / Prompts Scrollable Area
          Expanded(
            child: SingleChildScrollView(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Greeting & Welcome Card
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          AppColors.primary.withValues(alpha: 0.06),
                          const Color(0xFF8B5CF6).withValues(alpha: 0.04),
                        ],
                      ),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: AppColors.primary.withValues(alpha: 0.15)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.auto_awesome, color: Colors.white, size: 12),
                                  SizedBox(width: 4),
                                  Text(
                                    'AI Shopping Assistant',
                                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        const Text(
                          'Hi Rahul, what are you shopping for?',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Text(
                          'Say it the way you would to a friend. Add a budget, who it is for, or send a photo.',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),

                  // If Chat hasn't started, show starter prompts (Screen 07)
                  if (!_hasStartedChat) ...[
                    const Text(
                      'Start with one of these',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...List.generate(_starterPrompts.length, (index) {
                      final item = _starterPrompts[index];
                      return GestureDetector(
                        onTap: () => _sendQuery(item['query']!),
                        child: Container(
                          margin: const EdgeInsets.only(bottom: 10),
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceLight,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  item['category']!,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Text(
                                  item['title']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              const Icon(Icons.arrow_forward_rounded, size: 16, color: AppColors.primary),
                            ],
                          ),
                        ),
                      );
                    }),
                  ] else ...[
                    // Conversational Messages (Screen 08)
                    ..._messages.map((msg) {
                      final isUser = msg['isUser'] as bool;
                      if (isUser) {
                        return Align(
                          alignment: Alignment.centerRight,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 16, left: 40),
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(18),
                                topRight: Radius.circular(18),
                                bottomLeft: Radius.circular(18),
                                bottomRight: Radius.circular(4),
                              ),
                            ),
                            child: Text(
                              msg['text'],
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        );
                      } else {
                        final products = msg['products'] as List<ProductModel>? ?? [];
                        final followUps = msg['followUps'] as List<String>? ?? [];

                        return Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // AI Message text
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                decoration: BoxDecoration(
                                  color: AppColors.surfaceLight,
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(18),
                                    topRight: Radius.circular(18),
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(18),
                                  ),
                                  border: Border.all(color: AppColors.border),
                                ),
                                child: Text(
                                  msg['text'],
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 14),

                              // Curated Product Cards
                              ...products.map((p) => GestureDetector(
                                onTap: () => ProductDetailSheet.show(context, p),
                                child: Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16),
                                    border: Border.all(color: AppColors.border),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withValues(alpha: 0.04),
                                        blurRadius: 10,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          p.imageUrl,
                                          width: 74,
                                          height: 74,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              p.storeName,
                                              style: const TextStyle(
                                                fontSize: 11,
                                                color: AppColors.textSecondary,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              p.title,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.textPrimary,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Row(
                                              children: [
                                                Text(
                                                  '\$${p.price.toInt()}',
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w800,
                                                    color: AppColors.primary,
                                                  ),
                                                ),
                                                const SizedBox(width: 6),
                                                if (p.originalPrice > p.price)
                                                  Text(
                                                    '\$${p.originalPrice.toInt()}',
                                                    style: const TextStyle(
                                                      fontSize: 12,
                                                      decoration: TextDecoration.lineThrough,
                                                      color: AppColors.textMuted,
                                                    ),
                                                  ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textSecondary),
                                        onPressed: () => ProductDetailSheet.show(context, p),
                                      ),
                                    ],
                                  ),
                                ),
                              )),

                              // Follow up Suggestions Chips
                              if (followUps.isNotEmpty) ...[
                                const SizedBox(height: 8),
                                Wrap(
                                  spacing: 8,
                                  runSpacing: 8,
                                  children: followUps.map((chip) => ActionChip(
                                    label: Text(chip),
                                    labelStyle: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                      color: AppColors.primary,
                                    ),
                                    backgroundColor: AppColors.primary.withValues(alpha: 0.08),
                                    side: BorderSide(color: AppColors.primary.withValues(alpha: 0.2)),
                                    onPressed: () => _sendQuery(chip),
                                  )).toList(),
                                ),
                              ],
                            ],
                          ),
                        );
                      }
                    }),
                  ],
                ],
              ),
            ),
          ),

          // Bottom Input Field & Disclaimer
          Container(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    // Camera Action
                    IconButton(
                      icon: const Icon(Icons.camera_alt_outlined, color: AppColors.textSecondary, size: 22),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const PhotoSearchScreen()),
                        );
                      },
                    ),
                    // Mic Action
                    IconButton(
                      icon: const Icon(Icons.mic_none_rounded, color: AppColors.textSecondary, size: 22),
                      onPressed: () => VoiceSearchSheet.show(context),
                    ),
                    // Input Text
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        decoration: BoxDecoration(
                          color: AppColors.surfaceLight,
                          borderRadius: BorderRadius.circular(24),
                          border: Border.all(color: AppColors.border),
                        ),
                        child: TextField(
                          controller: _textController,
                          style: const TextStyle(fontSize: 14),
                          onSubmitted: _sendQuery,
                          decoration: const InputDecoration(
                            hintText: 'Ask for anything, like a gift under \$50',
                            hintStyle: TextStyle(color: AppColors.textMuted, fontSize: 13),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Send Button
                    GestureDetector(
                      onTap: () => _sendQuery(_textController.text),
                      child: Container(
                        width: 40,
                        height: 40,
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.arrow_upward_rounded, color: Colors.white, size: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Answers can be wrong. Check price and details on the product page.',
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
