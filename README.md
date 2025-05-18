# RevoTime

## Project Description

RevoTime is a modern and beautifully designed reminder application built with Flutter. It helps users organize their tasks and events by creating reminders categorized into different groups like Payments, Events, Work, Personal, Health, Education, Shopping, and Social. With its intuitive user interface, smooth animations, and localization support, RevoTime aims to provide a seamless and enjoyable experience for managing daily reminders.

## Features

- **User Authentication**: Secure login flow (with mock implementation for now) and token management.
- **Categorized Reminders**: Organize reminders into predefined groups.
- **Reminder Details**: View detailed lists of upcoming and past reminders within each group.
- **Interactive UI**: Animated elements and a modern design theme using light blue as the primary color.
- **Localization**: Support for multiple languages (English and Turkish implemented).
- **Notifications**: Integration with OneSignal for push notifications.
- **Network Layer**: Structured network service using Dio with an interceptor for authentication.
- **Local Storage**: Utilization of SharedPreferences and Hive for local data storage.

## Technical Overview

RevoTime is developed using Flutter, Google's UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.

Key technologies and packages used:

- **Flutter**: UI framework.
- **Provider/Bloc (Planned/Partial)**: For state management.
- **Dio**: For handling HTTP network requests.
- **Shared Preferences**: For simple key-value local storage (used for authentication token).
- **Hive**: For fast and efficient local NoSQL database (planned for reminders).
- **OneSignal**: For push notification services.
- **Lottie**: For adding engaging animations.
- **flutter_localizations**: For internationalization and localization.
- **get_it/injectable**: For dependency injection (planned/partial).

## Getting Started

To get a local copy up and running follow these simple steps.

### Prerequisites

- Flutter SDK installed.
- A physical device or emulator/simulator to run the app.
- Xcode (for iOS development).

### Installation

1. Clone the repository:
   ```bash
   git clone <repository_url>
   ```
2. Navigate to the project directory:
   ```bash
   cd revotime
   ```
3. Get project dependencies:
   ```bash
   flutter pub get
   ```
4. Generate localization files:
   ```bash
   flutter gen-l10n
   ```
5. For iOS development, navigate to the `ios` directory and install pods:
   ```bash
   cd ios
   pod install
   cd ..
   ```

### Running the App

- Connect a device or start an emulator/simulator.
- Run the app from the project root:
   ```bash
   flutter run
   ```
   Or select a device and run from your IDE (VS Code, Android Studio, etc.).

## Project Structure

The project follows a layered architecture to ensure maintainability and scalability:

```
revotime/
├── lib/
│   ├── core/         # Core functionalities (network, theme, services, widgets, localization)
│   ├── features/     # Feature-specific implementations (auth, home, reminders)
│   └── main.dart     # Application entry point
├── assets/
│   └── animations/   # Lottie animation files
├── ios/
├── android/
├── l10n.yaml       # Localization configuration
├── pubspec.yaml    # Project dependencies
├── README.md       # Project README
└── ... other files![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 01 17 24](https://github.com/user-attachments/assets/9a7dc36d-f610-4318-b373-0925517549c8)

```

## ScreenShot


![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 01 17 10](https://github.com/user-attachments/assets/7da7523c-a862-49bb-a60e-aac5c5fa51d6)
![Simulator Screenshot - iPhone 16 Pro - 2025-05-19 at 01 18 35](https://github.com/user-attachments/assets/9294b1c5-cbbd-40d2-879d-ba636365f190)


