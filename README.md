# Sticky Flutter Shop

Sticky Shop is an online store built with Flutter where users can browse, customize, and purchase unique stickers. The app includes product browsing, a shopping cart, user authentication, and a smooth checkout flow. It aims to offer a clean UI, fast navigation, and a fun shopping experience.

## Getting Started

### Step 1: Clone Repository
```bash
git clone https://github.com/Elyn03/task-manager.git
cd task-manager
```
### Step 2: Install Dependencies
```bash
flutter pub get
flutter run
```
This will install all required packages
### Step 3: Setup Firebase
1. Create new Firebase project : [Firebase Console](https://console.firebase.google.com/)
3. Click "Add project"
4. Follow the setup
5. Enable Firebase Authentication:
   - Navigate to Authentication > Sign-in method
   - Enable Email/Password provider
6. Install Firebase CLI
```bash
npm install -g firebase-tools
firebase login
```
7. Activate Firebase CLI
```bash
dart pub global activate flutterfire_cli
```
8. Configure Firebase CLI
```bash
flutterfire configure
```

### Step 4: Run project
```bash
flutter run
```

## Functionality
- Browse a **catalog**
  - search & filters
- View **product details**
- **Add to cart**
- **Checkout** orders
- View **order history**
- **Create account**

