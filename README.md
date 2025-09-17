# FoodHunt

![Frontend](https://img.shields.io/badge/frontend-Flutter-blue.svg)
![Framework](https://img.shields.io/badge/backend-NestJS-red.svg)
![License](https://img.shields.io/badge/license-MIT-blue.svg)

<p align="center"\>
  <img width="1920" height="495" alt="image" src="https://github.com/user-attachments/assets/3f1f740b-b43e-492c-92e7-343aa1e9df44" />
</p\>

**A Real-time restaurant discovery app that helps you and your friends discover and recommend dining spots in any locations, transforming the "where to eat" dilemma into a fun, interactive, and rewarding experience through real-time location tracking, user reviews, and gamification.**

-----

## 🧠 Problem Background

Deciding where to eat, especially when hanging out with friends, can often be a challenge:

  * Many people struggle to find new and suitable dining places when spontaneous meetups occur.
  * Reliable and up-to-date recommendations are often hard to come by, leading to repetitive choices or unsatisfactory experiences.
  * Restaurants, especially smaller ones, often lack effective ways to gain exposure and attract new customers.
  * Existing food recommendation platforms may not fully leverage real-time location or gamification to enhance user engagement.

## 🌈 Our Vision

**FoodHunt** hadir untuk menyederhanakan proses pencarian tempat makan, mengubah setiap momen kebingungan menjadi petualangan kuliner yang menyenangkan. Melalui teknologi pelacakan lokasi real-time, rekomendasi berbasis ulasan pengguna, dan elemen gamifikasi, kami memberdayakan pengguna untuk menemukan, berbagi, dan menikmati pengalaman makan yang tak terlupakan. Kami juga membantu restoran mendapatkan eksposur yang mereka butuhkan.

We aim to provide an accessible, engaging, and effective companion for anyone looking for the perfect dining spot, turning meal decisions into an exciting hunt.

## ✨ Key Features

  * **Real-time Location Tracking:** Discover nearby restaurants instantly based on your current location (like Zenly).
  * **Personalized Recommendations:** Get suggestions tailored to your preferences, dining history, and popular user reviews.
  * **User Reviews & Ratings:** Read and contribute honest reviews and ratings for various dining establishments.
  * **Gamification:**
      * **Badges & Achievements:** Earn badges for trying new places, leaving reviews, or achieving dining streaks.
      * **Leaderboards:** Compete with friends for top reviewer or explorer status.
      * **Points System:** Accumulate points for every interaction (reviews, check-ins, recommendations) which can be redeemed for rewards.
  * **Restaurant Partnerships:**
      * **Promotional Information:** Access exclusive deals, discounts, and menu highlights from partner restaurants.
      * **Targeted Ads:** Partner restaurants can display advertisements to relevant users based on location and preferences.
  * **Interactive Map Interface:** Visually explore dining options, friend locations, and recommended routes.
  * **Social Sharing:** Easily share your dining experiences and recommendations with friends.

## 👥 Target Audience

  * Individuals aged 18-35 who frequently dine out or look for new places to eat, especially in groups.
  * Food enthusiasts and explorers keen on discovering hidden gems and sharing their culinary adventures.
  * Restaurants (especially small to medium-sized businesses) seeking increased visibility, customer engagement, and promotional opportunities.
  * Users who enjoy gamified experiences and social interaction within apps.

## 🛠️ Technology Stack

  * **Frontend:** Flutter
  * **Backend:** NestJS
  * **Database:** PostgreSQL
  * **Messaging Queue:** Kafka
  * **Location Services:** CoreLocation
  * **Mapping:** MapKit
  * **Language:** Dart (for Flutter), TypeScript (for NestJS)
  * **Platform:** iOS, Android
  * **State Management:** Provider/Riverpod (for Flutter), NestJS built-in (for Backend)
  * **Custom Fonts:** (To be determined)

## 🧑‍💻 Getting Started

This project is a monorepo containing the frontend (Flutter) and backend (NestJS). Follow the steps below to get each part running locally.

### Prerequisites

- **General:**
  - Git
- **Backend:**
  - Node.js (v18 or later recommended)
  - npm or yarn
  - A running instance of PostgreSQL
  - A running instance of Kafka
- **Frontend:**
  - Flutter SDK (v3.x.x or later)
  - An IDE like Visual Studio Code or Android Studio with the Flutter extension
  - Xcode (for iOS development)
  - Android Studio (for Android development)

---

### 1. Clone the Repository

```bash
git clone https://github.com/williamtheodoruswijaya/FoodHunt
cd FoodHunt
````

---

### 2. Backend Setup (NestJS)

1. Navigate to the backend directory:

   ```bash
   cd backend
   ```
2. Install dependencies:

   ```bash
   npm install
   ```
3. Set up environment variables:

   * Create a `.env` file by copying the `.env.example` file.
   * Fill in the required variables, such as your `DATABASE_URL` for PostgreSQL and your Kafka broker connection details.
4. Run Prisma migrations and generate client:

   ```bash
   npx prisma migrate dev --name init
   npx prisma generate
   ```
5. Start the development server:

   ```bash
   npm run start:dev
   ```

   The backend API should now be running, typically on `http://localhost:3000`.

---

### 3. Frontend Setup (Flutter)

1. Navigate to the frontend directory:

   ```bash
   # From the root directory
   cd frontend
   ```
2. Get Flutter packages:

   ```bash
   flutter pub get
   ```
3. Run the application:

   * Make sure you have a simulator (iOS) or an emulator (Android) running, or a physical device connected.
   * Run the app from your IDE or use the following command:

     ```bash
     flutter run
     ```
     
## 💰 Revenue Stream

  * **Restaurant Partnerships:** Collaboration with restaurants for:
      * **Advertisement Placement:** Restaurants pay to display targeted ads within the app.
      * **Featured Listings:** Restaurants pay for premium placement in recommendations or search results.
      * **Promotional Packages:** Restaurants pay for bundled services including event promotion, special offers, and data insights.

## 👨‍👩‍👧‍👦 Our Team

FoodHunt is brought to you by:

  * **Davin Miguel** - 
  * **Novellina Edyawati** - UI/UX & Mobile Developer
  * **Reynard Setiawan** - Mobile Developer
  * **Yoel Kharis Wijaya** - Backend Developer
  * **William Theodorus Wijaya** - Project Manager & Backend Developer

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](https://www.google.com/search?q=LICENSE) file for details.
