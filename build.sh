#!/bin/bash

# Flutter JSON Serialization Build Script
echo "🔧 Running Flutter JSON Serialization Build..."

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Run build runner
echo "🏗️ Generating JSON serialization code..."
dart run build_runner build --delete-conflicting-outputs

echo "✅ Build completed successfully!"
echo "📝 Generated files:"
find lib -name "*.g.dart" -type f | head -10

echo ""
echo "🚀 You can now run your app with: flutter run"
