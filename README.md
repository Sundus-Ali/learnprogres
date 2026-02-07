# LearnProgress App

LearnProgress is a modern Learning Management System (LMS) designed to track student progress through text-based courses. The project consists of a Flutter mobile application and a Node.js/MongoDB backend.

## 🚀 Features

-   **User Authentication (Diiwaangelinta):** Secure Login and Registration with JWT.
-   **Course Dashboard (Bogga Hore):** View list of enrolled courses with progress bars.
-   **Reading Interface (Akhriska):** Clean, academic interface for reading long-form text lessons.
-   **Progress Tracking (Horumarka):** Mark lessons as completed and see progress update instantly (e.g., 45% -> 50%).
-   **Profile System (Cududda):** Student profile with stats (GPA, Credits) and settings.
-   **Backend API:** Robust REST API built with Express.js and MongoDB.

## 🛠️ Technology Stack

### Frontend (Mobile App)
-   **Framework:** Flutter (Dart)
-   **State Management:** GetX (Simple & Reactive)
-   **Networking:** http package
-   **Storage:** shared_preferences
-   **UI:** Google Fonts, Percent Indicator, Flutter Markdown

### Backend (Server)
-   **Runtime:** Node.js
-   **Framework:** Express.js
-   **Database:** MongoDB (with Mongoose)
-   **Authentication:** JSON Web Tokens (JWT) & bcryptjs

## 📂 Project Structure

```learnprogress/
├── lib/                 # Flutter mobile application source code
│   ├── controllers/     # GetX controllers that manage business logic, state updates, and user interactions
│   ├── models/          # Dart data models representing Users, Courses, Lessons, and Progress objects
│   ├── services/        # Handles API communication (HTTP requests to the backend server)
│   ├── views/           # UI screens such as Login, Dashboard, Course Details, Lesson, Progress, and Profile
│   └── main.dart        # Application entry point that initializes GetX, routes, and theme configuration
│
├── server/              # Node.js backend responsible for data processing and storage
│   ├── controllers/     # Logic that processes incoming requests (authentication, course retrieval, progress updates)
│   ├── models/          # Mongoose schemas defining how data is structured in MongoDB
│   ├── routes/          # REST API endpoint definitions that connect URLs to controller functions
│   ├── config/          # Database connection setup and environment configuration
│   └── server.js        # Main server file that starts the Express server and registers middleware and routes


```
**Brief Project Documentation**

This project consists of two main components:

Mobile Application:
This is the application used by students to access learning materials and monitor their progress. The app is built using Flutter, and GetX is used for state management to efficiently handle application data and UI updates.

Server (Backend):
This is where all data, including user information, courses, lessons, and progress records, is stored and managed. The backend is developed using Node.js with Express, and MongoDB is used as the database.

When a student completes a lesson, the mobile app sends a request to the server (“Mark as Completed”). The server then updates the lesson status and recalculates the overall course progress percentage for that student.
## ⚙️ Setup Instructions

### 1. Backend Setup
```bash
cd server
npm install
# Create .env file with MONGO_URI and JWT_SECRET
node seeder.js # (Optional) To populate fake data
node server.js
```

### 2. Frontend Setup
```bash
# From root directory
flutter pub get
flutter run
```


**Developed by:** 
Sundus Ali

Maida mohamed

Ali Mohamed

Mohamed Dahir

**Date:** Feb 7, 2026
