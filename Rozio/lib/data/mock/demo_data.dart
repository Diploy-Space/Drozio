import '../models/cart_item_model.dart';
import '../models/product_model.dart';

/// Professional centralized demo data for Rozio E-Commerce.
class DemoData {
  DemoData._();

  // Featured & Catalog Products
  static const List<ProductModel> products = [
    ProductModel(
      id: 'prod_1',
      title: 'Pro Wireless Earbuds ANC',
      storeName: 'Glow Audio',
      isStoreVerified: true,
      price: 59.0,
      originalPrice: 79.0,
      rating: 4.8,
      reviewsCount: 428,
      imageUrl: 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=600&auto=format&fit=crop',
      availableColors: ['Ivory', 'Matte Black', 'Midnight Blue'],
      availableEditions: ['Standard', 'Active Noise Cancelling (ANC)', 'Pro Wireless Case'],
      storePositiveRating: '99% positive',
      storeShippingSpeed: 'Ships in 30 mins',
      deliveryDateText: 'Express delivery in 30 mins',
    ),
    ProductModel(
      id: 'prod_2',
      title: 'Nova AMOLED Smartwatch Series X',
      storeName: 'Urban Tech Co',
      isStoreVerified: true,
      price: 89.0,
      originalPrice: 129.0,
      rating: 4.9,
      reviewsCount: 892,
      imageUrl: 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=600&auto=format&fit=crop',
      availableColors: ['Space Grey', 'Rose Gold', 'Obsidian Black'],
      availableEditions: ['40mm Bluetooth', '44mm GPS', '44mm Cellular + GPS'],
      storePositiveRating: '97% positive',
      storeShippingSpeed: 'Ships in 2 hours',
      deliveryDateText: 'Express delivery by Today, 6 PM',
    ),
    ProductModel(
      id: 'prod_3',
      title: 'Women Classic White Leather Sneakers',
      storeName: 'Cool Sneakers',
      isStoreVerified: true,
      price: 70.0,
      originalPrice: 95.0,
      rating: 4.7,
      reviewsCount: 215,
      imageUrl: 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=600&auto=format&fit=crop',
      availableColors: ['Pure White', 'White & Beige', 'White & Navy'],
      availableEditions: ['UK 5', 'UK 6', 'UK 7', 'UK 8'],
      storePositiveRating: '96% positive',
      storeShippingSpeed: 'Ships next morning',
      deliveryDateText: 'Delivery by Tomorrow, 11 AM',
    ),
    ProductModel(
      id: 'prod_4',
      title: 'Mechanical RGB Gaming Keyboard (Hot-swap)',
      storeName: 'Apex Gaming',
      isStoreVerified: true,
      price: 110.0,
      originalPrice: 150.0,
      rating: 4.9,
      reviewsCount: 654,
      imageUrl: 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=600&auto=format&fit=crop',
      availableColors: ['Retro White', 'Cyber Black'],
      availableEditions: ['Red Linear Switches', 'Brown Tactile Switches', 'Blue Clicky Switches'],
      storePositiveRating: '99% positive',
      storeShippingSpeed: 'Ships in 24h',
      deliveryDateText: 'Delivery in 2 business days',
    ),
    ProductModel(
      id: 'prod_5',
      title: '18K White Gold Diamond Pendant Necklace',
      storeName: 'Rozio Luxury Vault',
      isStoreVerified: true,
      price: 1680.0,
      originalPrice: 2400.0,
      rating: 5.0,
      reviewsCount: 88,
      imageUrl: 'https://images.unsplash.com/photo-1599643478518-a784e5dc4c8f?w=600&auto=format&fit=crop',
      availableColors: ['18K White Gold', '18K Yellow Gold', 'Rose Gold'],
      availableEditions: ['0.5 Carat Solitaire', '1.0 Carat Solitaire + Certificate'],
      storePositiveRating: '100% verified authentic',
      storeShippingSpeed: 'Insured Armored Express',
      deliveryDateText: 'Insured delivery by Friday',
    ),
    ProductModel(
      id: 'prod_6',
      title: 'Samsung Galaxy S24 Ultra 5G (256GB)',
      storeName: 'Hanover Electronics',
      isStoreVerified: true,
      price: 1150.0,
      originalPrice: 1300.0,
      rating: 4.8,
      reviewsCount: 1420,
      imageUrl: 'https://images.unsplash.com/photo-1610945265064-0e34e5519bbf?w=600&auto=format&fit=crop',
      availableColors: ['Titanium Gray', 'Titanium Black', 'Titanium Violet'],
      availableEditions: ['256GB / 12GB RAM', '512GB / 12GB RAM', '1TB Enterprise'],
      storePositiveRating: '98% positive',
      storeShippingSpeed: 'Ships same day',
      deliveryDateText: 'Free delivery by Tomorrow',
    ),
  ];

  // Pre-seeded multi-seller cart items for immediate live demo
  static List<CartItemModel> get initialCartItems => [
    CartItemModel(
      product: products[0], // Pro Wireless Earbuds ANC
      selectedColor: 'Matte Black',
      selectedEdition: 'Active Noise Cancelling (ANC)',
      quantity: 1,
    ),
    CartItemModel(
      product: products[1], // Nova AMOLED Smartwatch
      selectedColor: 'Space Grey',
      selectedEdition: '44mm GPS',
      quantity: 1,
    ),
  ];

  // Rich Demo Orders for OrdersScreen
  static const List<Map<String, dynamic>> demoOrders = [
    {
      'id': 'RZ-83921',
      'date': 'Today, 2:45 PM',
      'title': 'Pro Wireless Earbuds ANC',
      'store': 'Glow Audio',
      'price': 59.0,
      'status': 'Out for delivery · Arriving in 15 mins',
      'statusColor': 0xFF16A34A,
      'imageUrl': 'https://images.unsplash.com/photo-1590658268037-6bf12165a8df?w=400',
    },
    {
      'id': 'RZ-77120',
      'date': 'Oct 24, 2026',
      'title': 'Nova AMOLED Smartwatch Series X',
      'store': 'Urban Tech Co',
      'price': 89.0,
      'status': 'Delivered',
      'statusColor': 0xFF64748B,
      'imageUrl': 'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400',
    },
    {
      'id': 'RZ-65209',
      'date': 'Oct 19, 2026',
      'title': 'Women Classic White Leather Sneakers',
      'store': 'Cool Sneakers',
      'price': 70.0,
      'status': 'In Transit · Dispatched',
      'statusColor': 0xFF2563EB,
      'imageUrl': 'https://images.unsplash.com/photo-1549298916-b41d501d3772?w=400',
    },
    {
      'id': 'RZ-54110',
      'date': 'Sep 12, 2026',
      'title': 'Mechanical RGB Gaming Keyboard',
      'store': 'Apex Gaming',
      'price': 110.0,
      'status': 'Delivered',
      'statusColor': 0xFF64748B,
      'imageUrl': 'https://images.unsplash.com/photo-1587829741301-dc798b83add3?w=400',
    },
  ];
}
