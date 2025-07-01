
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

## 📁 Project Structure

```
lib/
├── app/                      # Core app logic
│   ├── bindings/             # Dependency injections
│   │   └── bindings.dart
│   ├── controllers/          # All GetX controllers
│   └── utils/                # Shared utilities
│       ├── secrets.dart
│
├── presentation/             # UI screens & widgets
│   ├── screens
│   └── widgets               # Reusable UI components
│       └── (your widgets here)
│
└── main.dart                 # App entry point
```

---

✅ **Tip:** You can add more subfolders in `widgets` or `screens` as your app grows.

---

Let me know if you’d like me to tweak anything further!

---

## 🌍 Stay tuned...

Messaging, user profiles, and real-time sync — all coming soon.

---

## 🛠 Built with

* Flutter 💙
* Supabase 🔐
* GetX ⚡
* Google Fonts 🔤

---

## 👨‍💻 Made by Kartik

Follow for updates, forks & collabs.

---
