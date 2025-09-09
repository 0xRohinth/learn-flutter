## 🔹 What we did in Flutter (Dart side)

1. **Created a Flutter app** with:
    
    - `Product` model (data structure for products).
        
    - `DBHelper` (SQLite helper using `sqflite`).
        
    - `ProductProvider` (state management using `ChangeNotifier`).
        
    - `ProductListScreen` (UI screen showing product list + FAB).
        
    - `AddProductScreen` (form screen to add products).
        
2. **Integrated SQLite**
    
    - Used `sqflite` package to store data **offline**.
        
    - DB file is created inside:
        
        `/data/data/com.example.stock_manager/databases/stock_manager.db`
        
    - Products are inserted → fetched → displayed in UI.
        
3. **State Management**
    
    - `ChangeNotifierProvider` was used → when we add a product, it **notifies UI** and updates the product list.
        
4. **UI Navigation**
    
    - Used `Navigator.push` to go to Add Product screen.
        
    - On save → `Navigator.pop` returns to Product List and refreshes it.
        

So, Flutter handles **UI + Business Logic + DB integration**.

---

## 🔹 What we fixed in Android (native side)

1. **AndroidManifest.xml**
    
    - This file defines:
        
        - App **package name** → `com.example.stock_manager`
            
        - **MainActivity** → entry point when app starts
            
        - Permissions (Internet, storage, etc.)
            
    - Without this, Flutter couldn’t launch app on Android.
        
2. **`flutter create .`**
    
    - This regenerated missing Android/iOS folders.
        
    - Inside `android/`, we now have:
        
        - `app/src/main/AndroidManifest.xml`
            
        - `MainActivity.kt` (bridges Flutter with Android)
            
        - `build.gradle` (tells Gradle how to build your app)
            
    - These are required for Flutter to run on Android.
        
3. **Gradle + Android Studio**
    
    - Android Studio uses **Gradle** to compile the app.
        
    - Flutter runs Dart code inside a **Flutter Engine** (on Android), which is linked by the `MainActivity`.
        

So, Android side handles **native bootstrapping**, while Flutter side handles **UI and logic**.

---

## 🔹 Big Picture (What we learned)

- Flutter code (`lib/`) = Your app’s logic + UI.
    
- Android code (`android/`) = The “shell” that lets Flutter run on Android devices.
    
- `AndroidManifest.xml` = Like a "passport" for your app (name, permissions, entry point).
    
- `sqflite` = SQLite DB engine for offline storage (works only on Android/iOS, not web).