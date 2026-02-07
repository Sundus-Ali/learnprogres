# LearnProgress - Learning Progress Tracking System

A mobile application designed to help students track their learning progress, view courses, and mark lessons as completed.

## 📱 Features
- **User Roles**: Student, Teacher, Admin.
- **Authentication**: Secure Login & Registration (JWT-based).
- **Dashboard**: View enrolled courses and progress bars.
- **Lessons**: Watch video lessons and mark them as completed.
- **Progress**: Visual statistics of your learning journey.
- **Localization**: Somali documentation comments in the code.

## 🛠 Technology Stack
- **Frontend**: Flutter (Dart) with Provider State Management.
- **Backend**: Node.js, Express.js.
- **Database**: MongoDB.
- **Architecture**: MVVM (Model-View-ViewModel).
- **Design**: Charcoal Blue & Dusty Denim theme.

## 🚀 How to Run

### 1. Backend (Node.js)
The backend manages users and data.
```bash
cd server
npm install
npm start
```
*Server runs on `http://localhost:5000`*

### 2. Frontend (Flutter)
Ensure you have an emulator running (Android/iOS).
```bash
flutter pub get
flutter run
```

## 📂 Project Structure
- `lib/views/`: UI Screens (Login, Dashboard, etc.)
- `lib/viewmodels/`: Business Logic (Provider)
- `lib/services/`: API Calls
- `lib/models/`: Data Models
- `server/`: Node.js Backend Code

## 🌍 Deployment
See [DEPLOYMENT.md](DEPLOYMENT.md) for instructions on how to deploy the backend to Render/Railway and build the Android APK.