# PhotoPrompt AI

![Flutter](https://img.shields.io/badge/Flutter-3.24.0-02569B?style=for-the-badge&logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.5.0-0175C2?style=for-the-badge&logo=dart)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

> Create stunning AI-generated images with text prompts using FLUX.1 Schnell

## ✨ Features

- **AI Image Generation** - Generate beautiful images from text descriptions
- **FLUX.1 Schnell Integration** - Free tier powered by Replicate API
- **Modern Dark UI** - Premium creative tool aesthetic with smooth animations
- **Responsive Design** - Works beautifully on desktop and mobile
- **Quick Prompts** - Pre-built creative prompts for inspiration
- **Download & Share** - Save your creations easily

## 🚀 Tech Stack

- **Flutter 3.24.0** - Cross-platform UI framework
- **Dart 3.5** - Modern programming language
- **Replicate API** - AI model hosting (FLUX.1 Schnell)
- **GitHub Actions** - CI/CD for automated deployments
- **GitHub Pages** - Free hosting

## 📁 Project Structure

```
lib/
├── main.dart                    # App entry point
├── app.dart                     # Root widget configuration
└── core/
    └── config/
        ├── constants.dart       # Colors, spacing, theme constants
        └── themes.dart          # Dark theme configuration
└── features/
    └── home/
        └── screens/
            └── generation_screen.dart  # Main generation UI
```

## 🎨 UI Preview

The app features a premium dark theme with:
- Vibrant purple/pink gradient accents
- Animated loading states
- Glass-morphism effect cards
- Responsive two-column layout on desktop
- Smooth transitions and micro-interactions

## 🛠️ Local Development

```bash
# Install dependencies
flutter pub get

# Run locally
flutter run -d chrome

# Build for web
flutter build web --release --base-href /photoprompt-ai/
```

## 🔌 API Integration

The app uses the [Replicate API](https://replicate.com/) with the free **FLUX.1 Schnell** model:
- 50 free credits per month
- ~1923 free generations
- Max resolution: 1024x1024

To enable full image generation:
1. Get your API token from [Replicate](https://replicate.com/account/api-tokens)
2. Add your token to the API configuration

## 🚢 Deployment

The app is automatically deployed to GitHub Pages via GitHub Actions on every push to `main`.

**Live URL**: https://govindtank.github.io/photoprompt-ai/

## 📄 License

MIT License - feel free to use this project for learning and development.

---

Made with ❤️ using Flutter
