#!/bin/bash

echo "🚀 Начинаем сборку..."

# Сборка APK
flutter build apk --release

# Получаем имя приложения из pubspec.yaml
APP_NAME=$(grep '^name:' pubspec.yaml | sed 's/name: //' | tr -d '\r')

# Получаем версию
VERSION=$(grep 'version:' pubspec.yaml | sed 's/version: //' | tr -d '\r')
DATE=$(date +%Y%m%d_%H%M%S)

# Пути
APK_PATH="build/app/outputs/flutter-apk/app-release.apk"
ZIP_NAME="${APP_NAME}_v${VERSION}_${DATE}.zip"

if [ -f "$APK_PATH" ]; then
    zip -j "$ZIP_NAME" "$APK_PATH"
    rm "$APK_PATH"
    echo "✅ ZIP архив создан: $ZIP_NAME"
    ls -lh "$ZIP_NAME"
else
    echo "❌ APK не найден"
    exit 1
fi