# 📱 Petstore App

A **Petstore App app** built with [Flutter](https://flutter.dev/) ⚡, using [GetX](https://pub.dev/packages/get) for state management and [PetStore3](https://petstore3.swagger.io/) as the data source.  
The app provides a smooth experience to CRUD the pet data

---

## ✨ Features

- 🎨 Modern & clean UI  
- 📋 Create, Read, Update, Delete pet in admin web app
- 🗂 Browse list in mobile app and simulate the purchase  
- 🚀 Built with **Flutter**, **GetX**, and **GetStorage**

---

## 🛠️ Tech Stack

- **Flutter** (Dart)
- **GetX** – State management & navigation
- **GetStorage** – Local storage
- **Petstore3** – Petstore data source

---

## 🚀 Getting Started

### 1. Clone the repository
```bash
git clone https://github.com/afifhanig/petstore-app-code.git
cd petstore_app
```

### 2. Run Pub Get
```bash
flutter pub get
```

### 3. Run the App
```bash
flutter run -d chrome //for web app admin
flutter run -d ios/android //for mobile app
```

---

## 🧪 Running Tests
This project uses flutter_test and mockito for unit testing.

### 1. Run all tests with:
```bash
flutter test
```

### 2. Run a specific test file:
```bash
flutter test test/domain/usecases/create_pet_test.dart
```

### 3. Run tests with detailed output:
```bash
flutter test --coverage
```

---

## 🤝 Contributing
- Contributions are welcome! Feel free to fork this repo and submit a pull request.

---

## 🙌 Acknowledgements
- [Petstore3](https://petstore3.swagger.io/) for the amazing Pet data
- Flutter & Dart community ❤️ 

