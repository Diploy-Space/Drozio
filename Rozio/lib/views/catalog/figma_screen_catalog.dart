import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../data/models/product_model.dart';
import '../../data/models/cart_item_model.dart';

// Import all screens
import '../onboarding/language_selection_screen.dart';
import '../onboarding/pincode_location_screen.dart';
import '../onboarding/location_flow_screens.dart';
import '../auth/login_bottom_sheet.dart';
import '../auth/otp_verification_screen.dart';
import '../auth/account_recovery_screens.dart';
import '../home/home_screen.dart';
import '../search/search_screen.dart';
import '../search/voice_search_sheet.dart';
import '../search/photo_search_screen.dart';
import '../search/photo_results_screen.dart';
import '../search/rozio_ai_screen.dart';
import '../search/search_results_screen.dart';
import '../search/sort_bottom_sheet.dart';
import '../search/filters_bottom_sheet.dart';
import '../categories/categories_screen.dart';
import '../deals/flash_deal_screen.dart';
import '../deals/clearance_sale_screen.dart';
import '../deals/first_order_screen.dart';
import '../deals/featured_products_screen.dart';
import '../store/top_stores_screen.dart';
import '../brands/brands_screen.dart';
import '../brands/brand_detail_screen.dart';
import '../notifications/notifications_screen.dart';
import '../reels/reels_screen.dart';
import '../reels/shop_this_video_sheet.dart';
import '../product/product_detail_sheet.dart';
import '../product/offers_bottom_sheet.dart';
import '../product/product_detail_screen.dart';
import '../product/ratings_reviews_screen.dart';
import '../product/questions_answers_screen.dart';
import '../product/size_guide_sheet.dart';
import '../product/compare_products_screen.dart';
import '../cart/cart_screen.dart';
import '../cart/added_to_bag_sheet.dart';
import '../checkout/change_address_sheet.dart';
import '../checkout/checkout_address_screen.dart';
import '../checkout/add_address_screen.dart';
import '../checkout/checkout_summary_screen.dart';
import '../checkout/coupons_bottom_sheet.dart';
import '../checkout/checkout_payment_screen.dart';
import '../checkout/payment_processing_screen.dart';
import '../checkout/payment_detail_screens.dart';
import '../checkout/order_placed_screen.dart';
import '../orders/orders_screen.dart';
import '../orders/order_details_screen.dart';
import '../orders/live_tracking_screen.dart';
import '../orders/order_help_screen.dart';
import '../orders/support_chat_screen.dart';
import '../orders/cancel_order_screen.dart';
import '../orders/rate_purchase_screen.dart';
import '../orders/return_replace_screen.dart';
import '../store/store_preview_sheet.dart';
import '../store/store_detail_screen.dart';
import '../store/store_chat_screen.dart';

class FigmaScreenItem {
  final String badge;
  final String title;
  final String category;
  final String description;
  final void Function(BuildContext context) onOpen;

  const FigmaScreenItem({
    required this.badge,
    required this.title,
    required this.category,
    required this.description,
    required this.onOpen,
  });
}

class FigmaScreenCatalogScreen extends StatefulWidget {
  const FigmaScreenCatalogScreen({super.key});

  @override
  State<FigmaScreenCatalogScreen> createState() => _FigmaScreenCatalogScreenState();
}

class _FigmaScreenCatalogScreenState extends State<FigmaScreenCatalogScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _filter = '';
  String _selectedCategory = 'All';

  final ProductModel _sampleProduct = const ProductModel(
    id: 'prod_earbuds_anc',
    title: 'Pro Wireless Earbuds ANC',
    storeName: 'Glow Audio',
    price: 59.0,
    originalPrice: 79.0,
    imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400&auto=format&fit=crop',
    availableColors: ['Ivory', 'Black', 'Blue'],
    availableEditions: ['Standard', 'Pro', 'Pro Max'],
  );

  static const Map<String, String> _sampleAddress = {
    'title': 'Home',
    'recipient': 'Rahul Sharma',
    'address': 'Flat 402, Lotus Grand, Link Road, Andheri West, Mumbai 400053',
    'phone': '+91 98765 43210',
  };

  late final List<FigmaScreenItem> _allScreens = [
    // Onboarding & Language
    FigmaScreenItem(
      badge: 'A02',
      title: 'Language Selection',
      category: 'Onboarding',
      description: 'Choose from 8 Indian languages with live preview update',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LanguageSelectionScreen())),
    ),
    FigmaScreenItem(
      badge: 'A03',
      title: 'Location Permission Intro',
      category: 'Onboarding',
      description: 'First run prompt explaining why pincode is required',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LocationIntroScreen())),
    ),
    FigmaScreenItem(
      badge: 'A04',
      title: 'Location Permission Dialog',
      category: 'Onboarding',
      description: 'System-style location permission modal',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LocationIntroScreen())),
    ),
    FigmaScreenItem(
      badge: 'A05',
      title: 'Location Found & Confirm',
      category: 'Onboarding',
      description: 'Shows found address on mock map with one-tap confirm',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LocationFoundScreen())),
    ),
    FigmaScreenItem(
      badge: 'A06',
      title: 'Enter Pincode Manually',
      category: 'Onboarding',
      description: '6-digit pincode validation for delivery areas',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ManualPincodeScreen())),
    ),
    FigmaScreenItem(
      badge: 'A07',
      title: 'Location Not Delivered',
      category: 'Onboarding',
      description: 'Notice when outside serviceable area with browse option',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ManualPincodeScreen())),
    ),

    // Auth & Recovery
    FigmaScreenItem(
      badge: 'A08',
      title: 'Log In or Sign Up',
      category: 'Auth',
      description: 'Phone number login bottom sheet with benefits',
      onOpen: (ctx) => LoginBottomSheet.show(ctx),
    ),
    FigmaScreenItem(
      badge: 'A09',
      title: 'Log In From Add to Bag',
      category: 'Auth',
      description: 'Contextual auth prompt triggered from Bag/Buy now',
      onOpen: (ctx) => LoginBottomSheet.show(ctx),
    ),
    FigmaScreenItem(
      badge: 'A10',
      title: 'Log In Invalid Number',
      category: 'Auth',
      description: 'Validation error feedback for incorrect phone length',
      onOpen: (ctx) => LoginBottomSheet.show(ctx),
    ),
    FigmaScreenItem(
      badge: 'A13',
      title: 'Verify OTP',
      category: 'Auth',
      description: '6-digit OTP verification with 30s resend timer',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const OtpVerificationScreen(phoneNumber: '9876543210'))),
    ),
    FigmaScreenItem(
      badge: 'A14',
      title: 'Verify OTP Verifying',
      category: 'Auth',
      description: 'Animated spinner during code verification',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const OtpVerificationScreen(phoneNumber: '9876543210'))),
    ),
    FigmaScreenItem(
      badge: 'A15',
      title: 'Verify OTP Wrong Code',
      category: 'Auth',
      description: 'Error feedback with attempts countdown',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const OtpVerificationScreen(phoneNumber: '9876543210'))),
    ),
    FigmaScreenItem(
      badge: 'A17',
      title: 'Recover Account',
      category: 'Auth',
      description: 'Enter email to receive recovery authorization',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RecoverAccountScreen())),
    ),
    FigmaScreenItem(
      badge: 'A18',
      title: 'Recover Email Code',
      category: 'Auth',
      description: '6-digit email security code input',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RecoverEmailCodeScreen(email: 'user@rozio.com'))),
    ),
    FigmaScreenItem(
      badge: 'A19',
      title: 'Update Mobile Number',
      category: 'Auth',
      description: 'Enter new phone number to bind to account',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const UpdateNewNumberScreen())),
    ),
    FigmaScreenItem(
      badge: 'A21',
      title: 'Profile Setup: Your Name',
      category: 'Auth',
      description: 'Name input for invoice and delivery recipient',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ProfileSetupScreen())),
    ),
    FigmaScreenItem(
      badge: 'A22',
      title: 'Referral Code',
      category: 'Auth',
      description: 'Optional friend referral for extra discount coins',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ProfileSetupScreen())),
    ),
    FigmaScreenItem(
      badge: 'A23',
      title: 'Account Created',
      category: 'Auth',
      description: 'Celebration state unlocking coupon FIRST5',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ProfileSetupScreen())),
    ),

    // Main App & Search
    FigmaScreenItem(
      badge: '01',
      title: 'Home Full Scroll',
      category: 'Home',
      description: 'Complete 4638px feed with stories, deals, reels, and stores',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const HomeScreen())),
    ),
    FigmaScreenItem(
      badge: '02',
      title: 'Choose Delivery Location',
      category: 'Home',
      description: 'Pincode selector with saved Mumbai addresses',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const PincodeLocationScreen())),
    ),
    FigmaScreenItem(
      badge: '03',
      title: 'Search Screen',
      category: 'Search & AI',
      description: 'Voice, photo, recent searches & trending queries',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const SearchScreen())),
    ),
    FigmaScreenItem(
      badge: '04',
      title: 'Voice Search Sheet',
      category: 'Search & AI',
      description: 'Listening waveform animation with speech recognition simulation',
      onOpen: (ctx) => VoiceSearchSheet.show(ctx),
    ),
    FigmaScreenItem(
      badge: '05',
      title: 'Photo Search Camera',
      category: 'Search & AI',
      description: 'Camera view with crop frame & gallery picker',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const PhotoSearchScreen())),
    ),
    FigmaScreenItem(
      badge: '06',
      title: 'Photo Search Results',
      category: 'Search & AI',
      description: 'Visual matching products from image query',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const PhotoResultsScreen(detectedCategory: 'Sneakers', resultsCount: 14))),
    ),
    FigmaScreenItem(
      badge: '07',
      title: 'Rozio AI Assistant',
      category: 'Search & AI',
      description: 'Natural language shopping recommendations',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RozioAiScreen())),
    ),
    FigmaScreenItem(
      badge: '08',
      title: 'Rozio AI Answers',
      category: 'Search & AI',
      description: 'Interactive conversation stream with product cards',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RozioAiScreen())),
    ),
    FigmaScreenItem(
      badge: '09',
      title: 'Rozio AI Chat History',
      category: 'Search & AI',
      description: 'Saved queries and past shopping advice',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RozioAiScreen())),
    ),
    FigmaScreenItem(
      badge: '10',
      title: 'Search Suggestions',
      category: 'Search & AI',
      description: 'Live typing suggestions with product counts',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const SearchScreen())),
    ),
    FigmaScreenItem(
      badge: '11',
      title: 'Search Results Page',
      category: 'Search & AI',
      description: 'Grid/List product results with sort & filter toolbar',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const SearchResultsScreen(query: 'smart watch'))),
    ),
    FigmaScreenItem(
      badge: '12',
      title: 'Sort Bottom Sheet',
      category: 'Search & AI',
      description: 'Price, popularity, newest and rating sorting options',
      onOpen: (ctx) => SortBottomSheet.show(ctx, 'Relevance'),
    ),
    FigmaScreenItem(
      badge: '13',
      title: 'Filters Bottom Sheet',
      category: 'Search & AI',
      description: 'Price range slider, discount, rating and in-stock filters',
      onOpen: (ctx) => FiltersBottomSheet.show(ctx, FilterState()),
    ),
    FigmaScreenItem(
      badge: '14',
      title: 'Search No Results',
      category: 'Search & AI',
      description: 'Empty query state with recommended alternative searches',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const SearchResultsScreen(query: 'xyznonexistent123'))),
    ),

    // Deals & Stores
    FigmaScreenItem(
      badge: '15',
      title: 'Categories Catalog',
      category: 'Deals & Stores',
      description: 'All 8 retail categories with visual banners',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CategoriesScreen())),
    ),
    FigmaScreenItem(
      badge: '16',
      title: 'Flash Deal Live',
      category: 'Deals & Stores',
      description: 'Hourly countdown ticker with time slots & up to 20% off',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const FlashDealScreen())),
    ),
    FigmaScreenItem(
      badge: '17',
      title: 'Clearance Sale',
      category: 'Deals & Stores',
      description: 'Last-chance items up to 70% off with category tabs',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ClearanceSaleScreen())),
    ),
    FigmaScreenItem(
      badge: '18',
      title: 'First-Order Exclusives',
      category: 'Deals & Stores',
      description: 'New user welcome pricing with code FIRST5',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const FirstOrderExclusivesScreen())),
    ),
    FigmaScreenItem(
      badge: '19',
      title: 'Featured Products',
      category: 'Deals & Stores',
      description: 'Trending and top-rated curated catalog',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const FeaturedProductsScreen())),
    ),
    FigmaScreenItem(
      badge: '20',
      title: 'Top Stores',
      category: 'Deals & Stores',
      description: 'Verified merchants directory with follower counters',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const TopStoresScreen())),
    ),
    FigmaScreenItem(
      badge: '21',
      title: 'Brands Directory',
      category: 'Deals & Stores',
      description: 'A-Z directory of official store brands',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const BrandsScreen())),
    ),
    FigmaScreenItem(
      badge: '22',
      title: 'Brand Profile Page',
      category: 'Deals & Stores',
      description: 'Official brand storefront with story highlights',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const BrandDetailScreen(brandName: 'Samsung', category: 'Electronics', followers: '450k'))),
    ),
    FigmaScreenItem(
      badge: '23',
      title: 'Notifications Center',
      category: 'Deals & Stores',
      description: 'Live order tracking alerts, flash deal and coupon notices',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const NotificationsScreen())),
    ),

    // Reels Player
    FigmaScreenItem(
      badge: '24',
      title: 'Shoppable Reels Player',
      category: 'Reels Video',
      description: 'Full-screen TikTok-style shoppable video feed with dock',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ReelsScreen())),
    ),
    FigmaScreenItem(
      badge: '25',
      title: 'Buy From a Reel',
      category: 'Reels Video',
      description: 'Quick variant selector without interrupting video playback',
      onOpen: (ctx) => ProductDetailSheet.show(ctx, _sampleProduct),
    ),
    FigmaScreenItem(
      badge: '26',
      title: 'Reels Following Tab',
      category: 'Reels Video',
      description: 'Feed filtered to creators & stores you follow',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ReelsScreen())),
    ),
    FigmaScreenItem(
      badge: '28',
      title: 'Live Stream Mode',
      category: 'Reels Video',
      description: 'Live merchant selling with real-time viewer stream',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ReelsScreen())),
    ),
    FigmaScreenItem(
      badge: '30',
      title: 'Shop This Video Sheet',
      category: 'Reels Video',
      description: 'Side drawer showing all products tagged in active video',
      onOpen: (ctx) => ShopThisVideoSheet.show(ctx, [_sampleProduct]),
    ),

    // Product Decision
    FigmaScreenItem(
      badge: '31',
      title: 'Pick Options Sheet',
      category: 'Product',
      description: 'Color, edition, size and quantity bottom drawer',
      onOpen: (ctx) => ProductDetailSheet.show(ctx, _sampleProduct),
    ),
    FigmaScreenItem(
      badge: '32',
      title: 'Bank Offers & EMI Sheet',
      category: 'Product',
      description: 'Instant credit card discounts, cashback & EMI table',
      onOpen: (ctx) => OffersBottomSheet.show(ctx),
    ),
    FigmaScreenItem(
      badge: '33',
      title: 'Full Product Details Page',
      category: 'Product',
      description: 'High-res image gallery, specs, size guide & reviews',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => ProductDetailScreen(product: _sampleProduct))),
    ),
    FigmaScreenItem(
      badge: '35',
      title: 'Ratings & Reviews',
      category: 'Product',
      description: '4.7-star breakdown bars with buyer photo uploads',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => RatingsReviewsScreen(product: _sampleProduct))),
    ),
    FigmaScreenItem(
      badge: '36',
      title: 'Questions & Answers',
      category: 'Product',
      description: 'Community FAQ and verified buyer answers',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const QuestionsAnswersScreen())),
    ),
    FigmaScreenItem(
      badge: '37',
      title: 'Size Guide Sheet',
      category: 'Product',
      description: 'Measurements in inches and cm with sizing table',
      onOpen: (ctx) => SizeGuideSheet.show(ctx),
    ),
    FigmaScreenItem(
      badge: '39',
      title: 'Compare 3 Products',
      category: 'Product',
      description: 'Side-by-side comparison table highlighting differences',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => CompareProductsScreen(baseProduct: _sampleProduct))),
    ),
    FigmaScreenItem(
      badge: '40',
      title: 'Change Delivery Address',
      category: 'Product',
      description: 'Quick address switcher from product page',
      onOpen: (ctx) => ChangeAddressSheet.show(ctx),
    ),

    // Bag & Cart
    FigmaScreenItem(
      badge: '43',
      title: 'Added to Bag Sheet',
      category: 'Cart',
      description: 'Confirmation drawer with subtotal & instant checkout CTA',
      onOpen: (ctx) => AddedToBagSheet.show(
        ctx,
        CartItemModel(product: _sampleProduct, selectedColor: 'Black', selectedEdition: 'Standard', quantity: 1),
      ),
    ),
    FigmaScreenItem(
      badge: '44',
      title: 'Shopping Bag / Cart Tab',
      category: 'Cart',
      description: 'Itemized bag with quantity counters and price totals',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CartScreen())),
    ),
    FigmaScreenItem(
      badge: '45',
      title: 'Empty Bag State',
      category: 'Cart',
      description: 'Friendly illustration with CTA to explore trending reels',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CartScreen())),
    ),

    // Checkout Flow
    FigmaScreenItem(
      badge: '47',
      title: 'Checkout: Step 1 Address',
      category: 'Checkout',
      description: 'Saved addresses with delivery estimates & Add New CTA',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CheckoutAddressScreen())),
    ),
    FigmaScreenItem(
      badge: '48',
      title: 'Add New Address Form',
      category: 'Checkout',
      description: 'Full GPS pinned address form with landmark & address type',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const AddAddressScreen())),
    ),
    FigmaScreenItem(
      badge: '49',
      title: 'Checkout: Step 2 Summary',
      category: 'Checkout',
      description: 'Speed selection, bill breakdown & coupon application',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CheckoutSummaryScreen(selectedAddress: _sampleAddress))),
    ),
    FigmaScreenItem(
      badge: '50',
      title: 'GSTIN Business Invoice',
      category: 'Checkout',
      description: 'Claim B2B input tax credit on order summary',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CheckoutSummaryScreen(selectedAddress: _sampleAddress))),
    ),
    FigmaScreenItem(
      badge: '51',
      title: 'Coupons & Offers Sheet',
      category: 'Checkout',
      description: 'Apply promo codes REEL10, FIRST5 or festive cashbacks',
      onOpen: (ctx) => CouponsBottomSheet.show(ctx),
    ),
    FigmaScreenItem(
      badge: '52',
      title: 'Checkout: Step 3 Payment',
      category: 'Checkout',
      description: 'Multi-payment method selector: UPI, Cards, NetBanking, COD',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CheckoutPaymentScreen(totalAmount: 54.0, address: _sampleAddress))),
    ),
    FigmaScreenItem(
      badge: '53',
      title: 'Pay by Credit / Debit Card',
      category: 'Checkout',
      description: 'Secure card number, expiry, CVV & RBI tokenization',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const PayByCardScreen())),
    ),
    FigmaScreenItem(
      badge: '55',
      title: 'Pay with Net Banking',
      category: 'Checkout',
      description: 'Major banks list: HDFC, SBI, ICICI, Axis, Kotak',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const NetBankingScreen())),
    ),
    FigmaScreenItem(
      badge: '56',
      title: 'Redeem Gift Card',
      category: 'Checkout',
      description: 'Apply 16-digit card number & PIN to order',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const GiftCardScreen())),
    ),
    FigmaScreenItem(
      badge: '57',
      title: 'Payment Processing',
      category: 'Checkout',
      description: 'Animated pulse spinner while bank confirms payment',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const PaymentProcessingScreen(amount: 54.0, method: 'Google Pay', address: _sampleAddress))),
    ),
    FigmaScreenItem(
      badge: '58',
      title: 'Payment Failed State',
      category: 'Checkout',
      description: 'Failure explanation with 1-tap retry different method',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const PaymentFailedScreen())),
    ),
    FigmaScreenItem(
      badge: '59',
      title: 'Order Placed Confirmation',
      category: 'Checkout',
      description: 'Success state with delivery OTP (8492) and live tracking link',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const OrderPlacedScreen(orderId: '#ROZ-84920', amount: 54.0, address: _sampleAddress))),
    ),

    // Orders & Tracking
    FigmaScreenItem(
      badge: '60',
      title: 'My Orders List',
      category: 'Orders & Help',
      description: 'Order history tabs: Active, Delivered, and Cancelled',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const OrdersScreen())),
    ),
    FigmaScreenItem(
      badge: '61',
      title: 'Order Details & Timeline',
      category: 'Orders & Help',
      description: '4-step delivery progress, courier info & invoice download',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const OrderDetailsScreen(orderId: '#ROZ-84920'))),
    ),
    FigmaScreenItem(
      badge: '62',
      title: 'Live Map Courier Tracking',
      category: 'Orders & Help',
      description: 'Real-time GPS courier partner (Sunil Verma) route to home',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const LiveTrackingScreen(orderId: '#ROZ-84920'))),
    ),
    FigmaScreenItem(
      badge: '63',
      title: 'Help with this Order',
      category: 'Orders & Help',
      description: 'FAQs, delivery delays, item issues and instant resolution',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const OrderHelpScreen(orderId: '#ROZ-84920'))),
    ),
    FigmaScreenItem(
      badge: '64',
      title: 'Support Real-Time Chat',
      category: 'Orders & Help',
      description: 'Chat with Rozio Care agent with attachment upload',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const SupportChatScreen(orderId: '#ROZ-84920'))),
    ),
    FigmaScreenItem(
      badge: '65',
      title: 'Cancel Order Flow',
      category: 'Orders & Help',
      description: 'Select cancellation reason and refund destination',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const CancelOrderScreen(orderId: '#ROZ-84920'))),
    ),
    FigmaScreenItem(
      badge: '67',
      title: 'Rate Your Purchase',
      category: 'Orders & Help',
      description: 'Star rating, product feedback tags & photo review',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const RatePurchaseScreen(orderId: '#ROZ-84920'))),
    ),
    FigmaScreenItem(
      badge: '68',
      title: 'Return or Replace Scheduler',
      category: 'Orders & Help',
      description: '7-day replacement pickup scheduler with courier time slot',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const ReturnReplaceScreen(orderId: '#ROZ-84920'))),
    ),

    // Stores & Merchants
    FigmaScreenItem(
      badge: '70',
      title: 'Store Preview Sheet',
      category: 'Store Profile',
      description: 'Store rating, verification badge and top products snippet',
      onOpen: (ctx) => StorePreviewSheet.show(ctx, 'Glow Audio'),
    ),
    FigmaScreenItem(
      badge: '71',
      title: 'Store Profile: Reels Tab',
      category: 'Store Profile',
      description: 'All shoppable video reels published by the merchant',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const StoreDetailScreen(storeName: 'Glow Audio'))),
    ),
    FigmaScreenItem(
      badge: '72',
      title: 'Store Profile: Products Tab',
      category: 'Store Profile',
      description: 'Full merchant catalog with in-store search & category filters',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const StoreDetailScreen(storeName: 'Glow Audio'))),
    ),
    FigmaScreenItem(
      badge: '73',
      title: 'Chat with Store Merchant',
      category: 'Store Profile',
      description: 'Direct live messaging with seller regarding stock & warranty',
      onOpen: (ctx) => Navigator.push(ctx, MaterialPageRoute(builder: (_) => const StoreChatScreen(storeName: 'Glow Audio'))),
    ),
  ];

  List<String> get _categories {
    final cats = _allScreens.map((s) => s.category).toSet().toList();
    cats.sort();
    return ['All', ...cats];
  }

  List<FigmaScreenItem> get _filteredScreens {
    return _allScreens.where((s) {
      final matchesCat = _selectedCategory == 'All' || s.category == _selectedCategory;
      final q = _filter.toLowerCase().trim();
      final matchesSearch = q.isEmpty ||
          s.badge.toLowerCase().contains(q) ||
          s.title.toLowerCase().contains(q) ||
          s.description.toLowerCase().contains(q);
      return matchesCat && matchesSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final list = _filteredScreens;

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: AppColors.textPrimary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '🎨 Figma All-Screen Navigator',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: AppColors.textPrimary),
            ),
            Text(
              '${_allScreens.length} Figma Screens · Tap any to open directly',
              style: const TextStyle(fontSize: 11, color: AppColors.textSecondary, fontWeight: FontWeight.w500),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Search & Filter header
          Container(
            color: Colors.white,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
            child: Column(
              children: [
                TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Search screen number or name (e.g. 59, reels, AI)...',
                    hintStyle: const TextStyle(color: AppColors.textMuted, fontSize: 13),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.primary, size: 20),
                    suffixIcon: _filter.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _filter = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: AppColors.surfaceLight,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                  ),
                  onChanged: (val) => setState(() => _filter = val),
                ),
                const SizedBox(height: 10),
                // Category Pills
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: _categories.map((c) {
                      final isSelected = _selectedCategory == c;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: ChoiceChip(
                          label: Text(c, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.bold : FontWeight.w500)),
                          selected: isSelected,
                          selectedColor: AppColors.primary,
                          labelStyle: TextStyle(color: isSelected ? Colors.white : AppColors.textPrimary),
                          onSelected: (_) => setState(() => _selectedCategory = c),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),

          // Count & info banner
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            color: const Color(0xFFEFF6FF),
            child: Row(
              children: [
                const Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 16),
                const SizedBox(width: 8),
                Text(
                  'Showing ${list.length} of ${_allScreens.length} Figma screens',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Color(0xFF1E40AF)),
                ),
              ],
            ),
          ),

          // Screens List
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: list.length,
              separatorBuilder: (_, _) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final item = list[index];
                return Material(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(14),
                  elevation: 0.5,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(14),
                    onTap: () => item.onOpen(context),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Row(
                        children: [
                          // Badge pill
                          Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              item.badge,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 13,
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 14),
                          // Title & description
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item.title,
                                        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14, color: AppColors.textPrimary),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: AppColors.surfaceLight,
                                        borderRadius: BorderRadius.circular(6),
                                        border: Border.all(color: AppColors.border),
                                      ),
                                      child: Text(item.category, style: const TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: AppColors.textSecondary)),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  item.description,
                                  style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: AppColors.textMuted),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
