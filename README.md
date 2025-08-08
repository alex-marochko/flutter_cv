# Flutter CV Website

A personal CV website built with Flutter to showcase development skills and provide a practical way to update and share resume content.

## 🚀 Key Features

- **Dynamic Content:** Resume data is fetched from **Google Sheets**, allowing real-time updates without redeploying the app.
- **PDF Export:** Users can download a PDF version of the resume directly from the website.
- **CI/CD:** Automated tests, linting, and formatting via **GitHub Actions** on every push and pull request.

## 🏗️ Architecture & Stack

The project follows **Clean Architecture** with a clear separation into:

- **Presentation:** UI and state management using [Bloc](https://bloclibrary.dev/)
- **Domain:** Core business logic and use cases
- **Data:** Integration with external sources (Google Sheets via API)

**Core Technologies:**

- [Flutter](https://flutter.dev/)
- [Bloc](https://pub.dev/packages/flutter_bloc)
- [get_it](https://pub.dev/packages/get_it) for dependency injection
- [http](https://pub.dev/packages/http) for networking
- [bloc_test](https://pub.dev/packages/bloc_test), [mocktail](https://pub.dev/packages/mocktail) for testing
- [Firebase Analytics](https://firebase.google.com/products/analytics) & [Crashlytics](https://firebase.google.com/products/crashlytics)

## 🔄 Data Flow

1. **Content Source:** Resume data is stored in a **Google Sheet**.
2. **Google Apps Script:** Serves as a lightweight REST API.
3. **Cloudflare Worker:** Acts as a proxy with active caching and rate limiting for backend protection.
4. **Flutter Web App:** Fetches and renders content dynamically.
5. **GitHub Pages:** Hosts the built Flutter Web app, automatically deployed on every push to the `main` branch via GitHub Actions.

This setup enables secure, fast, and redeploy-free content management.

## 📦 Published Package

This project includes a custom layout widget — [**mosaic_cloud**](https://pub.dev/packages/mosaic_cloud) — published on pub.dev.  
It creates a dynamic mosaic of widgets, used decoratively during app loading to demonstrate Flutter’s animation and layout capabilities.
---