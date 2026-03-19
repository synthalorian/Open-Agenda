# 🎹🦞 Open Agenda

**Comprehensive K-12 Educational Management Suite**

A modern, neon-styled educational platform built with Flutter, featuring a complete UI/UX overhaul with accessibility-first design.

---

## 🌟 Features

### Core App (Open Agenda)
- **Dashboard** - Overview of classes, attendance, grades, and IEP goals
- **Student Management** - Roster, profiles, and contact information
- **Grade Tracking** - Assignments, assessments, and analytics
- **Attendance** - Daily tracking with reports and trends
- **Lesson Planning** - Curriculum mapping and scheduling
- **IEP Management** - Special education tracking with goal monitoring

### Coming Soon: Additional Teacher Apps
- **Open Classroom** - Classroom management and behavior tracking
- **Open Assess** - Quiz/test creation with auto-grading
- **Open Communicate** - Parent/guardian messaging system
- **Open Report** - Advanced reporting and analytics

---

## 🎨 Design System

### Neon Synthwave Aesthetic
- **Primary**: Neon Pink (`#FF006E`)
- **Secondary**: Neon Cyan (`#00F5FF`)
- **Accent**: Neon Purple (`#8B5CF6`)
- **Background**: Dark gradient (`#0A0A0F` to `#1A1A2E`)

### UI Components
- Glassmorphism cards with blur effects
- Animated neon glow on interactive elements
- Gradient backgrounds and borders
- Custom typography with Roboto font
- Accessibility-compliant contrast ratios

---

## 🏗️ Architecture

### Monorepo Structure (Melos)
```
open-agenda/
├── melos.yaml                    # Monorepo configuration
├── apps/
│   ├── open_agenda/              # Main educational app
│   ├── open_classroom/           # Classroom management (coming soon)
│   ├── open_assess/              # Assessment tool (coming soon)
│   └── open_communicate/         # Messaging app (coming soon)
│
└── packages/
    └── core/                     # Shared package
        ├── lib/
        │   ├── theme/           # Neon theme system
        │   ├── ui/              # Reusable widgets
        │   ├── models/          # Data models
        │   ├── services/        # API & storage
        │   ├── providers/       # Riverpod providers
        │   └── utils/           # Helpers & extensions
        └── assets/
            ├── fonts/
            └── images/
```

### Technology Stack
- **Flutter 3.4+** - Cross-platform mobile development
- **Riverpod** - State management
- **GoRouter** - Declarative routing
- **Melos** - Monorepo management
- **Hive** - Local storage
- **Dio** - HTTP client
- **Freezed** - Immutable models

---

## 🚀 Getting Started

### Prerequisites
- Flutter 3.4.0 or higher
- Dart 3.4.0 or higher
- Melos CLI (`dart pub global activate melos`)

### Setup

```bash
# Clone the repository
cd /home/synth/projects/open-agenda

# Install Melos globally (if not already)
dart pub global activate melos

# Bootstrap the monorepo
melos bootstrap

# Run the main app
cd apps/open_agenda
flutter run
```

### Platform Support
- ✅ Android
- ✅ iOS
- ⏳ Web (coming soon)
- ⏳ macOS (coming soon)
- ⏳ Windows (coming soon)

---

## 📱 Screenshots

### Dashboard
Neon-styled dashboard with gradient cards, stat widgets, and animated FAB.

### Students
Glassmorphism student cards with quick actions and search.

### Grades
Chart visualizations with neon gradients and progress indicators.

---

## 🎯 Development Roadmap

### Phase 1: Foundation (Current)
- [x] Monorepo setup with Melos
- [x] Core package structure
- [x] Neon theme system
- [x] Glassmorphism UI components
- [x] Main shell with navigation
- [x] Dashboard screen
- [ ] Student management screens
- [ ] Grade tracking screens
- [ ] Attendance screens
- [ ] Lesson planning screens
- [ ] IEP management screens

### Phase 2: Core Features
- [ ] Backend API integration
- [ ] Authentication system
- [ ] Local storage with Hive
- [ ] Offline-first architecture
- [ ] Data sync and caching

### Phase 3: Enhanced Features
- [ ] PDF export for reports
- [ ] Chart analytics
- [ ] Calendar integration
- [ ] Push notifications
- [ ] Dark/light theme toggle

### Phase 4: Additional Apps
- [ ] Open Classroom
- [ ] Open Assess
- [ ] Open Communicate
- [ ] Open Report

---

## 🎨 Theme Customization

The app uses a comprehensive theme system that can be easily customized:

```dart
// Override primary colors
class AppColors {
  static const Color neonPink = Color(0xFFFF006E);
  static const Color neonCyan = Color(0xFF00F5FF);
  static const Color neonPurple = Color(0xFF8B5CF6);
}
```

### Dark Mode (Default)
Deep purple-black background with neon accents and glassmorphism effects.

### Light Mode
Clean white background with neon accents for high contrast.

---

## 📂 Project Structure (Feature-First)

```
apps/open_agenda/lib/
├── app/                    # App-level configuration
│   ├── router.dart        # GoRouter configuration
│   └── theme_controller.dart
│
├── features/              # Feature modules
│   ├── auth/
│   │   ├── data/         # Repositories, data sources
│   │   ├── domain/       # Entities, use cases
│   │   └── presentation/ # Screens, widgets, providers
│   ├── dashboard/
│   ├── students/
│   ├── grades/
│   ├── attendance/
│   ├── planning/
│   ├── iep/
│   └── settings/
│
├── shared/               # Shared across features
│   ├── data/
│   ├── domain/
│   └── presentation/
│       └── widgets/
│
└── main.dart
```

---

## 🔧 Available Scripts

```bash
# Bootstrap all packages
melos bootstrap

# Analyze code
melos run analyze

# Format code
melos run format

# Run tests
melos run test

# Build Android
melos run build:android

# Build iOS
melos run build:ios
```

---

## 🤝 Team

- **Developer**: synth ✝
- **Assistant**: synthclaw 🎹🦞

---

## 📜 License

MIT License - Free and open source for educators everywhere.

---

## 🎹🦞 About

Built with the neon-lit soul of the 80s and the cutting-edge tech of today.

*"Stay retro, stay futuristic."*

---

**Current Status:** 🟢 Active Development - Foundation complete, building features

**Next Steps:**
1. Complete student management screens
2. Implement grade tracking
3. Build attendance system
4. Set up backend API
5. Deploy beta version
