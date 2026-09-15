#!/bin/bash
set -e
flutter create --org com.meko --project-name meko .
flutter pub get
flutter analyze
flutter build apk --release
