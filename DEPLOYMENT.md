# Backend Deployment Guide (Hagaha Daabacaadda Server-ka)

Right now, your backend is running **locally** on your computer (`localhost`). To let other people use your app, you need to **deploy** it to the internet.

Hadda server-kaagu wuxuu ku shaqeynayaa kombiyuutarkaaga (`localhost`). Si dadka kale u isticmaalaan, waa inaad internet-ka gelisaa (Deploy).

We will use **Render.com** (for the Node.js server) and **MongoDB Atlas** (for the Database). Both have free tiers.

---

## Step 1: Set up MongoDB Atlas (Database-ka)

1.  Go to [MongoDB Atlas](https://www.mongodb.com/cloud/atlas) and sign up.
2.  Create a free **Cluster**.
3.  In **Database Access**, create a user (username/password).
4.  In **Network Access**, allow access from anywhere (`0.0.0.0/0`).
5.  Click **Connect** -> **Connect your application**.
6.  Copy the connection string (e.g., `mongodb+srv://<username>:<password>@cluster0.mongodb.net/...`).
    *   *Replace `<password>` with your actual password.*

---

## Step 2: Prepare Backend Code for Deployment

1.  Create a file named `vercel.json` in your `server` folder (if using Vercel) OR just sure your `package.json` has a `start` script:
    ```json
    "scripts": {
      "start": "node server.js",
      "dev": "nodemon server.js",
      "seed": "node seeder.js"
    }
    ```
    *(I have already done this for you)*.

2.  Push your code to **GitHub**.
    *   Create a repository on GitHub.
    *   Push your `learnprogres` folder (or just the `server` folder) to it.

---

## Step 3: Deploy to Render (Server-ka)

1.  Go to [Render.com](https://render.com) and sign up with GitHub.
2.  Click **New +** -> **Web Service**.
3.  Connect your GitHub repository.
4.  **Settings**:
    *   **Runtime:** Node
    *   **Build Command:** `npm install`
    *   **Start Command:** `node server.js`
5.  **Environment Variables** (Muhiim ah):
    *   Add `MONGO_URI`: Paste your MongoDB Atlas connection string from Step 1.
    *   Add `JWT_SECRET`: Put a long secret password here.
    *   Add `NODE_ENV`: `production`
6.  Click **Create Web Service**.

Wait a few minutes. Render will give you a **URL** (e.g., `https://learnprogress-api.onrender.com`).

---

## Step 4: Connect Flutter App

1.  Open `lib/core/api_constants.dart` in your Flutter project.
2.  Change the `baseUrl` to your new Render URL:
    ```dart
    static const String baseUrl = 'https://learnprogress-api.onrender.com/api';
    ```
    *(Halka `localhost` aad ka isticmaali lahayd URL-ka cusub)*
3.  Run `flutter build apk` to create the final app file for phones.

---

**Hambalyo!** Your app is now live on the internet.
