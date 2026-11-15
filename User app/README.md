# Drozio — User Application (Consumer & Wholesale Client)

A modern, high-performance Flutter mobile application for retail e-commerce, B2B wholesale transactions, live auction bidding, and real-time chat.

---

## 🛠 Tech Stack
- **Framework:** Flutter (>=3.24.0) / Dart (>=3.5.0)
- **Architecture:** Clean Architecture + Feature-First Domain-Driven Design (DDD)
- **State Management:** `Provider` (`ChangeNotifier`)
- **Navigation:** `GoRouter` declarative routing
- **Dependency Injection:** `GetIt` (`sl` Service Locator)
- **Networking:** `Dio` with interceptors and token refresh
- **Local Persistence:** `Drift` (SQLite) relational offline cache & `shared_preferences`
- **Analytics & Notifications:** Firebase Cloud Messaging (FCM)

---

## 📂 Architecture Overview

The codebase is organized into modular feature domains under `lib/features/`:

```
lib/
├── common/                  # Reusable UI widgets and base controllers
├── data/                    # Remote data sources, Dio client, interceptors
├── features/                # 60+ modular feature domains
│   ├── auth/                # Sign up, OTP, Social login (Google, Apple, Facebook)
│   ├── cart/                # Local/remote synchronized shopping cart
│   ├── checkout/            # Multi-address delivery & multi-gateway payments
│   ├── auction/             # Real-time bidding & auction participation
│   ├── wholesale/           # Tiered wholesale product purchasing
│   └── chat/                # In-app messaging with merchants
├── helper/                  # Formatting, price converters, network checkers
├── localization/            # Multi-language string catalogs
├── theme/                   # Light & dark theme palettes
└── utill/                   # Global constants, images, dimensions, styles
```

---

## 🚀 Getting Started

### 1. Configuration
Open `lib/utill/app_constants.dart` and configure your API URL:
```dart
static const String baseUrl = 'https://your-api-domain.com';
static const String appName = 'Drozio';
```

For Firebase Push Notifications:
- Android: Replace `android/app/google-services.json`
- iOS: Replace `ios/Runner/GoogleService-Info.plist`

### 2. Dependency Installation
```bash
flutter pub get
```

### 3. Code Generation (Drift DB / JSON)
If you update database tables or data classes, execute:
```bash
dart run build_runner build --delete-conflicting-outputs
```

### 4. Running the Application
```bash
# Debug Mode
flutter run

# Profile Mode
flutter run --profile

# Release Mode
flutter run --release
```

### 5. Static Code Analysis
To verify zero warnings and clean code compliance:
```bash
dart analyze .
```

---

## 📦 Building for Production

### Android (APK & App Bundle)
```bash
# Release APK
flutter build apk --release

# Google Play Store Bundle (.aab)
flutter build appbundle --release
```

### iOS (IPA)
```bash
flutter build ipa --release
```
