# E-Commerce Flutter App

A modern, feature-rich e-commerce mobile application built with Flutter and Firebase, following Clean Architecture principles and BLoC state management pattern.

## 🚀 Features

### Authentication & User Management
- **User Registration** - Complete signup flow with email, password, age, and gender selection
- **User Sign-In** - Secure email/password authentication
- **Password Reset** - Forgot password functionality with email reset
- **User Profile** - Display user information and preferences
- **Session Management** - Auto-login for authenticated users

### Shopping Experience
- **Home Screen** - Browse featured products and categories
- **Product Categories** - Dynamic category browsing with Firebase integration
- **Product Search** - Advanced search functionality
- **Top Selling Products** - Featured product recommendations
- **New Arrivals** - Browse the latest products
- **Product Cart** - Add, remove, and manage products in the shopping cart
- **Product Details** - View detailed information about each product
- **Notifications** - Receive updates and alerts

### Technical Features
- **Multi-Platform** - Android, iOS, Web, Windows, macOS, and Linux support
- **Real-time Updates** - Firebase Firestore real-time data sync
- **Error Handling** - Comprehensive error management with user feedback
- **Loading States** - Smooth loading indicators and skeleton screens

## 🏗️ Architecture

This project implements **Clean Architecture** with **BLoC Pattern** for state management:

```
├── Domain Layer (Business Logic)
│   ├── Entities
│   ├── Use Cases
│   └── Repository Interfaces
├── Data Layer (External Data)
│   ├── Models
│   ├── Data Sources (Firebase)
│   └── Repository Implementations
└── Presentation Layer (UI)
    ├── Pages
    ├── Widgets
    └── BLoC (State Management)
```

## 📁 Project Structure

```
lib/
├── main.dart                          # App entry point
├── firebase_options.dart              # Firebase configuration
├── service_locator.dart               # Dependency injection setup
│
├── core/                              # Core application functionality
│   ├── config/                        # App configuration
│   │   ├── assets/                     # Asset management
│   │   └── theme/                      # App theming
│   ├── constant/                       # App constants
│   └── usecase/                        # Base use case abstractions
│
├── common/                            # Shared components
│   ├── helper/                         # Utility functions
│   │   ├── navigator/                  # Navigation helpers
│   │   └── appbuttonsheet/             # Bottom sheet helpers
│   └── widget/                         # Reusable widgets
│       ├── appbar/                     # Custom app bars
│       ├── button/                     # Custom buttons
│       └── product/                    # Product widgets
│
└── features/                          # Feature modules
    ├── splash/                         # Splash screen
    │   ├── page/
    │   └── bloc/
    │
    ├── auth/                          # Authentication feature
    │   ├── data/
    │   │   ├── models/                 # User data models
    │   │   ├── source/                 # Firebase auth service
    │   │   └── repository/             # Auth repository implementation
    │   ├── domain/
    │   │   ├── entity/                 # User entities
    │   │   ├── repository/             # Auth repository interface
    │   │   └── usecase/                # Auth use cases
    │   └── presentation/
    │       ├── page/                   # Auth screens
    │       ├── widget/                 # Auth widgets
    │       └── bloc/                   # Auth state management
    │
    ├── home/                          # Home/Dashboard feature
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │       ├── page/                   # Home screen
    │       ├── widget/                 # Home widgets
    │       └── bloc/                   # Home state management
    │
    ├── category/                      # Product categories
    │   ├── data/
    │   │   ├── model/                  # Category models
    │   │   ├── source/                 # Category API service
    │   │   └── repository/             # Category repository
    │   ├── domain/
    │   │   ├── entity/                 # Category entities
    │   │   ├── repository/             # Category repository interface
    │   │   └── usecase/                # Category use cases
    │   └── presentation/               # Category UI (if needed)
    │
    ├── product/                       # Product details
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── cart/                          # Shopping cart
    │   └── presentation/
    │
    ├── search/                        # Search functionality
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── profile/                       # User profile
    │   └── presentation/
    │
    ├── notification/                  # Notifications
    │   ├── data/
    │   ├── domain/
    │   └── presentation/
    │
    ├── tabs/                          # Main tab navigation
    │   └── presentation/

assets/                                # App assets
├── fonts/                             # Custom fonts (CircularStd family)
├── images/                            # Image assets
└── vectors/                           # SVG icons

android/                               # Android platform files
ios/                                   # iOS platform files
web/                                   # Web platform files
windows/                               # Windows platform files
linux/                                # Linux platform files
macos/                                 # macOS platform files
```

## 🛠️ Tech Stack

### Frontend
- **Flutter** - Cross-platform UI framework
- **Dart** - Programming language
- **Material Design** - UI design system

### State Management
- **BLoC Pattern** - Business Logic Component pattern
- **flutter_bloc** - State management library

### Backend & Database
- **Firebase Auth** - User authentication
- **Cloud Firestore** - NoSQL database
- **Firebase Core** - Firebase integration

### Architecture & Patterns
- **Clean Architecture** - Separation of concerns
- **Repository Pattern** - Data access abstraction
- **Dependency Injection** - Using GetIt
- **SOLID Principles** - Code organization

### Additional Libraries
- **Dio** - HTTP client for API calls
- **Dartz** - Functional programming (Either type)
- **flutter_svg** - SVG asset support
- **get_it** - Service locator for dependency injection

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.4.3)
- Dart SDK
- Firebase project setup
- Android Studio / VS Code
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd Ecommerce
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Firebase Setup**
   - Create a Firebase project
   - Add your Firebase configuration files:
     - `android/app/google-services.json` (Android)
     - `ios/Runner/GoogleService-Info.plist` (iOS)
   - Update `lib/firebase_options.dart` with your Firebase config

4. **Run the application**
   ```bash
   flutter run
   ```

### Available Commands

```bash
# Run on specific platform
flutter run -d chrome          # Web
flutter run -d android         # Android
flutter run -d ios            # iOS

# Build for production
flutter build apk             # Android APK
flutter build web             # Web build
flutter build ios             # iOS build

# Run tests
flutter test

# Analyze code
flutter analyze

# Format code
dart format .
```

## 🔥 Firebase Configuration

### Firestore Collections
- **Users** - User profile data
- **Ages** - Age options for user registration
- **Categories** - Product categories
- **Products** - Product information (future implementation)

### Security Rules
Ensure proper Firebase security rules are configured for your collections.

## 🎨 UI/UX Features

- **Custom Typography** - CircularStd font family
- **Consistent Color Scheme** - Material Design colors
- **Responsive Design** - Adaptive layouts for different screen sizes
- **Smooth Animations** - Page transitions and loading animations
- **Error States** - User-friendly error messages
- **Loading States** - Professional loading indicators

## 🧪 Testing

The project includes unit tests and widget tests. Run tests with:

```bash
flutter test
```

## 📱 Platform Support

- ✅ **Android** (API 21+)
- ✅ **iOS** (iOS 11.0+)
- ✅ **Web** (Chrome, Firefox, Safari, Edge)
- ✅ **Windows** (Windows 10+)
- ✅ **macOS** (macOS 10.14+)
- ✅ **Linux** (64-bit)

## 🔮 Future Enhancements

- Payment integration
- Order management
- Push notifications
- Product reviews and ratings
- Wishlist feature
- Social authentication
- Dark mode support
- Internationalization (i18n)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 📞 Support

For support and questions, please open an issue in the repository.

---

Built with ❤️ using Flutter and Firebase
