# Flutter TODO App

A beautiful and intuitive TODO application built with Flutter, featuring local data persistence using Hive database and smooth user interactions.

## ✨ Features

- **Add Tasks**: Create new tasks with an intuitive dialog interface
- **Mark Complete**: Toggle task completion with smooth animations
- **Delete Tasks**: Swipe-to-delete functionality with slide actions
- **Persistent Storage**: All data is stored locally using Hive database
- **Clean UI**: Modern dark theme with smooth transitions
- **Responsive Design**: Works seamlessly across different screen sizes

## 🚀 Getting Started

### Prerequisites

- Flutter SDK (>=3.0.0)
- Dart SDK (>=2.17.0)
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/Gaygysyz05/flutter-todo-app.git
   cd flutter-todo-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

## 📦 Dependencies

| Package | Version | Description |
|---------|---------|-------------|
| [flutter](https://flutter.dev/) | SDK | UI framework |
| [hive_flutter](https://pub.dev/packages/hive_flutter) | ^1.1.0 | Lightweight NoSQL database |
| [flutter_slidable](https://pub.dev/packages/flutter_slidable) | ^3.0.0 | Swipe actions for list items |

## 🏗️ Project Structure

```
lib/
├── models/
│   └── todo_task.dart              # TodoTask model
├── repositories/
│   └── todo_repository.dart        # Data access layer
├── services/
│   └── todo_service.dart           # Business logic
├── presentation/
│   ├── controllers/
│   │   └── todo_controller.dart    # State management
│   ├── pages/
│   │   └── home_page.dart          # Main app screen
│   └── widgets/
│       ├── add_task_dialog.dart    # Add task dialog
│       ├── custom_button.dart      # Custom button component
│       ├── error_widget.dart       # Error display widget
│       └── todo_tile.dart          # Task list item widget
└── main.dart                       # App entry point
```

## 💡 Key Implementation Details

### Local Data Persistence
- Uses **Hive** for fast, lightweight local storage
- Automatically saves tasks when added, completed, or deleted
- Initializes with sample data on first launch

### User Experience
- **Swipe-to-delete**: Implemented with `flutter_slidable` package
- **Smooth animations**: Task completion toggles with visual feedback
- **Modal dialogs**: Clean task creation interface
- **Responsive layout**: Adapts to different screen sizes

### State Management
- Utilizes Flutter's built-in `StatefulWidget` for local state
- Efficient list updates with `ListView.builder`
- Real-time UI updates on data changes

## 🎨 Design Choices

- **Dark Theme**: Modern appearance with professional color scheme
- **Material Design**: Follows Google's design guidelines
- **Consistent Spacing**: Uniform padding and margins throughout
- **Color Palette**: 
  - Primary: `#2C3E50` (Dark blue-gray)
  - Secondary: `#34495E` (Lighter blue-gray)
  - Accent: Green theme colors

## 🔧 Customization

### Adding New Features
1. **Categories**: Extend the data model to include task categories
2. **Due Dates**: Add date picker for task deadlines
3. **Priority Levels**: Implement task priority system
4. **Search**: Add search functionality for large task lists

### Styling
- Modify colors in `ThemeData` in `main.dart`
- Update component styling in individual widget files
- Add custom fonts by updating `pubspec.yaml`

## 📱 Platform Support

- ✅ Android
- ✅ iOS  
- ✅ Web (with minor adjustments)
- ✅ Desktop (Windows, macOS, Linux)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- Hive developers for the excellent local database solution
- Material Design team for the design guidelines

---

**⭐ If you found this project helpful, please give it a star!**

## 📞 Contact

- GitHub: [@Gaygysyz05](https://github.com/Gaygysyz05)
- Email: niker6426@gmail.com

---

*Made with ❤️ and Flutter*