
# 🗨️ YAP – Connect. Chat. Evolve.

**YAP** isn’t just “Yet Another Platform” — it's your next-gen social hub built with style.
Fast, smooth, and scalable — YAP helps users connect through seamless onboarding, modern UI, and blazing realtime performance.

---

## ✨ Highlights

* 🔐 Auth powered by Supabase
* 🎨 Dark & Light Mode with custom themes
* 🚀 Lightning-fast navigation via GetX
* 🧠 Smart onboarding experience
* 📱 Ready for real-time chat & profile features

---

## 📲 Quick Start

1. **Clone the repo**

   ```bash
   git clone https://github.com/your-username/yap.git
   cd yap
   flutter pub get
   ```

2. **Add Supabase keys**
   Create a file at:
   `lib/app/utils/secrets.dart`
   And paste:

   ```dart
   class Secrets {
     static const supabaseUrl = 'YOUR_SUPABASE_URL';
     static const supabaseKey = 'YOUR_SUPABASE_ANON_KEY';
   }
   ```

3. **Run the app**

   ```bash
   flutter run
   ```

---

Absolutely! Here’s an **enhanced, more detailed folder structure** showing the next levels so it’s clear exactly where things live.
You can replace the *Project Structure* section in the README with this:

---

Sure—here’s a clean **project structure** section you can copy-paste directly into your README.md:

---

## 📂 Project Structure

```
lib/
├── app/
│   ├── bindings/        # Dependency bindings for controllers and services
│   ├── controllers/     # State management logic and controllers
│   ├── data/            # Data sources (local, remote)
│   ├── models/          # Model classes
│   ├── services/        # API and service classes
│   └── utils/           # Utility helpers and constants
├── presentation/
│   ├── routes/          # App routes and navigation
│   ├── screens/         # UI screens
│   └── widgets/         # Reusable UI components
└── main.dart            # Entry point of the application
```

---

## 🌍 Stay tuned...

Messaging, user profiles, and real-time sync — all coming soon.

---

## 🛠 Built with

* Flutter 💙
* Supabase 🔐
* GetX ⚡
* Google Fonts 🔤
* Cloudinary ☁

---

## 👨‍💻 Made by Kartik

Follow for updates, forks & collabs.

