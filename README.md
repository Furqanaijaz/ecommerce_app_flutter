A complete e-commerce mobile application built using Flutter and BLoC state management. This project follows clean architecture and consumes a REST API (e.g., DummyJSON) to fetch product data. The app features product listing, detailed product pages, wishlist functionality, and more.

📱 Features
✅ Home page with categories

🔎 Product search

🛒 Product listing by category or search

❤️ Add/Remove products from wishlist

🧾 Detailed product view (includes rating, tags, brand, etc.)

🔄 Similar product recommendation engine

🧠 Clean architecture using BLoC and domain layers

🧪 Error handling for API failures

🎨 Responsive and user-friendly UI

🧱 Project Structure (Clean Architecture)
bash
Copy
Edit
lib/
├── core/                   # Core utilities like error handling
├── data/                   # Models, repositories, data sources
│   └── source/             # Local or remote (API) sources
├── domain/                 # Entities and UseCases
│   ├── product/
│   │   ├── entity/
│   │   └── usecase/
├── presentation/           # UI layer + BLoC
│   ├── home/
│   ├── product/
│   └── wishlist/
├── routes/                 # Navigation & routing
├── service_locator.dart    # Dependency Injection
🔄 State Management
Used flutter_bloc for managing app state with Cubit for each feature:

GetProductCubit – handles fetching products

WishlistCubit – manages wishlist state

GetSimilarProductCubit – fetches similar products based on category, brand, or tags

GetCategoryCubit – loads categories from API

🌐 API Integration
The app uses DummyJSON or your custom REST API as the backend. APIs include:

GET /products

GET /products/categories

GET /products/search?q=

GET /products/category/:category

Error handling is done using Dartz Either type and Dio's exception system.

📦 Dependencies
yaml
Copy
Edit
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  dartz: ^0.10.1
  dio: ^5.3.2
  get_it: ^7.6.0
🧠 Similar Product Logic
In GetSimilarProductsUseCase, products are filtered based on:

Same category

Same brand

At least one matching tag

Partial match in title

dart
Copy
Edit
.where(
  (p) =>
    p.id != product.id &&
    (p.category == product.category ||
     p.brand == product.brand ||
     p.tags.any((tag) => product.tags.contains(tag)) ||
     p.title.contains(product.title))
)
❤️ Wishlist
Wishlist is managed using a BLoC Cubit.

Uses a simple List<ProductEntity> to store and toggle favorite status.

UI uses BlocBuilder to display the heart icon dynamically.

🧵 Tags
Tags are displayed under the product details section.

Each tag is clickable and can filter other products with that tag (optional).

🔙 Navigation
Back button uses Navigator.removeRoute or Navigator.pushReplacement to go back to a custom Navigation page.

dart
Copy
Edit
BackButton(
  onPressed: () => Navigator.pushReplacement(
    context,
    MaterialPageRoute(builder: (_) => Navigations()),
  ),
),
🧪 Error Handling
Dio exceptions are caught and mapped to readable messages.

All Cubits use .fold to handle Left (error) and Right (success) cases.

🚀 Getting Started
bash
Copy
Edit
git clone https://github.com/your-username/ecommerce-flutter-app.git
cd ecommerce-flutter-app
flutter pub get
flutter run
📷 Screenshots (Optional)
Add screenshots of the home page, product detail, wishlist, and similar product sections.

📌 Future Enhancements
Add local database (Hive/Isar) for wishlist persistence

Implement user authentication

Integrate cart and checkout system

Add image carousel on product detail page
