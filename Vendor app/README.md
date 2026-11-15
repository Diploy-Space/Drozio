# Drozio — Vendor Application (Merchant & POS Client)

An operational Flutter application designed for marketplace sellers to manage orders, inventory, products, clearance sales, and in-store Point of Sale (POS) with ESC/POS thermal printing.

---

## 🛠 Tech Stack
- **Framework:** Flutter (>=3.24.0) / Dart (>=3.5.0)
- **Architecture:** Clean Architecture + Feature-First Domain-Driven Design (DDD)
- **State Management:** `Provider` (`ChangeNotifier`)
- **Hardware Integrations:**
  - `print_bluetooth_thermal`: Bluetooth ESC/POS 58mm/80mm receipt printers
  - `flutter_barcode_scanner`: Barcode and QR code scanning for quick product lookup
- **AI Content Tools:** Gemini AI integration for automated product title, SEO keywords, and description generation
- **Networking:** `Dio` with authentication interceptors

---

## 📂 Architecture Overview

The codebase is organized under `lib/features/`:

```
lib/
├── common/                  # Reusable UI widgets and custom buttons
├── data/                    # Remote data sources, Dio client, interceptors
├── features/                # Modular seller features
│   ├── pos/                 # In-store POS cart, billing, customer selector
│   ├── addProduct/          # Multi-variation & digital product listing
│   ├── order/               # Order fulfillment, courier dispatch, tracking
│   ├── order_edit/          # Live order modification and replacement
│   ├── clearance_sale/      # Discount campaigns and clearance catalog
│   ├── auction/             # Auction management, claim tracking, payouts
│   └── chat/                # Real-time customer communication
├── helper/                  # Formatters, thermal printer helpers, image processors
├── localization/            # Multi-language string catalogs
├── theme/                   # Theme controllers and branding
└── utill/                   # App constants, dimensions, assets, styles
```

---

## 🚀 Getting Started

### 1. Configuration
Open `lib/utill/app_constants.dart` and update the base API URL:
```dart
static const String baseUrl = 'https://your-api-domain.com';
static const String appName = 'Drozio Vendor';
```

### 2. Device Permissions
- **Bluetooth:** Required for discovering and connecting to thermal receipt printers.
- **Camera:** Required for barcode and QR code product scanning.
- **Storage/Gallery:** Required for product and banner uploads.

### 3. Dependency Installation
```bash
flutter pub get
```

### 4. Running the Application
```bash
flutter run
```

### 5. Static Code Analysis
Verify that all code passes analysis with zero errors and warnings:
```bash
dart analyze .
```

---

## 📦 Building for Production

### Android
```bash
# Release APK
flutter build apk --release

# App Bundle for Google Play
flutter build appbundle --release
```

### iOS
```bash
flutter build ipa --release
```
