# LearnProgress App

LearnProgress is a modern Learning Management System (LMS) designed to track student progress through text-based courses. The project consists of a Flutter mobile application and a Node.js/MongoDB backend.

## 🚀 Features (Astaamaha)

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

```
learnprogress/
├── lib/                 # Flutter Code
│   ├── controllers/     # GetX Business Logic (Maamulka Xogta)
│   ├── models/          # Data Models (Qaabdhismeedka Xogta)
│   ├── services/        # API Communication (Xiriirka Server-ka)
│   ├── views/           # UI Screens (Muuqaalka)
│   └── main.dart        # Entry Point
├── server/              # Backend Code
│   ├── controllers/     # Request Handlers (Maamulka Codsiyada)
│   ├── models/          # Database Schemas (Shaxda Database-ka)
│   ├── routes/          # API Endpoints (Wadooyinka API-ga)
│   ├── config/          # DB Configuration
│   └── server.js        # Server Entry Point
```

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

## 📝 Somali Documentation (Faahfaahin Kooban)

Mashruucan wuxuu ka kooban yahay labo qeybood oo waaweyn:
1.  **Mobile App:** Waa appka ardaygu isticmaalayo si uu wax u barto, ugana  warqabo horumarkiisa. Waxaan isticmaalnay **GetX** si aan u maamulno xaaladaha (State Management) si ay u fududaato.
2.  **Server:** Waa halka xogta (Database) iyo macluumaadka koorsooyinka lagu keydiyo. Waxaan isticmaalnay **Node.js** iyo **MongoDB** oo ah teknooloojiyad casri ah.

Marka ardaygu cashar dhameeyo, app-ku wuxuu u diraa codsi server-ka ("Mark as Done"), server-kuna wuxuu dib u xisaabiyaa wadarta guud ee horumarka koorsada (Course Progress Percentage).

---
**Developed by:** [Your Group Name]
**Date:** Feb 7, 2026