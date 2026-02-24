# Bathtub Models – Mobile App

Flutter app for privacy-preserving transportation research (Bathtub Model).  
Raw GPS stays on-device; only anonymized Relative Trajectories are uploaded.

## Install Dart & Flutter (Windows)

1. **Option A – Manual (recommended)**  
   - Download the Flutter SDK: https://docs.flutter.dev/get-started/install/windows  
   - Extract to e.g. `C:\src\flutter`  
   - Add `C:\src\flutter\bin` to your PATH  

2. **Verify**  
   ```powershell
   flutter doctor
   dart --version
   ```

## Run

```bash
cd mobile
flutter pub get
flutter run
```

## Structure

- `lib/core/` – shared utilities, constants, extensions  
- `lib/data/` – GPS repository, local DB (raw data stays here)  
- `lib/domain/` – Bathtub service, relative trajectory, models  
- `lib/presentation/` – screens, Riverpod providers  
- `lib/features/` – tracking, privacy_dashboard, upload  
