# E-Commerce: Riverpod Shop

Laboratory Assignment for the course **'Mobile Application Programming'**

## Table of Contents

- [Goal](#goal)
- [Why Riverpod?](#why-riverpod)
- [Architecture](#architecture)
- [Screenshots](#screenshots)
  - [Products Screen](#products-screen)
  - [Search & Filter](#search--filter)
  - [Cart Screen](#cart-screen)
- [Performed by](#performed-by)

## Goal

This Flutter application is a small e-commerce shop built with Riverpod state management and a NeoBrutalism visual style. It demonstrates product listing, category filtering, live search, cart quantity management, total price calculation, and cart persistence with SharedPreferences.

**Requirements Fulfilled:**

- ✅ **Riverpod Setup:** The app is wrapped in `ProviderScope` in `main.dart`, and all product, cart, search, and filter state is managed with Riverpod providers.
- ✅ **Product Model:** `Product` includes immutable fields for id, name, price, category, and emoji image, plus `copyWith`, `toJson`, and `fromJson` methods.
- ✅ **Products Provider:** `productsProvider` exposes a read-only list of eight products across Electronics, Clothing, Books, and Kitchen categories.
- ✅ **Cart State Management (StateNotifier):** `CartNotifier` manages cart mutations including add, remove, increment, decrement, clear, load, and save operations.
- ✅ **Cart Screen with Total Price:** `CartScreen` displays cart items, item count, and a computed total price from `cartTotalProvider`.
- ✅ **Cart Badge + SnackBar:** The products screen app bar shows a cart badge from `cartCountProvider`, and checkout displays an `Order placed! 🎉` SnackBar.
- ✅ **Bonus A — Category Filter:** A horizontal row of category `FilterChip`s updates `filteredProductsProvider` and filters the product grid.
- ✅ **Bonus B — Quantity Controls:** Product cards and cart item tiles show NeoBrutalism quantity controls when products are already in the cart.
- ✅ **Bonus C — Cart Persistence (SharedPreferences):** Cart contents are serialized to SharedPreferences after mutations and loaded during `CartNotifier` initialization.
- ✅ **Bonus D — Product Search:** A search field updates `searchQueryProvider`, and `filteredProductsListProvider` combines search with category filtering.

## Why Riverpod?

Riverpod was used because it provides clear, testable, and composable state management without depending on widget tree context. `Provider` is used for read-only and computed state such as the product list, cart count, cart total, and filtered product list. `StateNotifierProvider` is used for the mutable cart state because the cart requires structured operations like adding products, changing quantities, clearing the cart, and persisting data. `StateProvider` is used for lightweight UI state such as the selected category filter and current search query. Widgets use `ref.watch` when they need to rebuild from provider changes and `ref.read` when they only need to trigger actions such as adding an item to the cart or clearing it.

## Architecture

```text
lib/
├── models/
│   └── product.dart
├── providers/
│   ├── products_provider.dart
│   └── cart_provider.dart
├── screens/
│   ├── widgets/
│   │   ├── product_card.dart
│   │   └── cart_item_tile.dart
│   ├── products_screen.dart
│   └── cart_screen.dart
├── theme/
│   └── app_theme.dart
└── main.dart
```

## Screenshots

### Products Screen

<img width="428" height="928" alt="image" src="https://github.com/user-attachments/assets/a4869824-877d-4888-acfc-51acd9898e61" />


---

### Search & Filter

<img width="435" height="930" alt="image" src="https://github.com/user-attachments/assets/e291373f-a254-4d7e-a754-fc6562fa1fbf" />


---

### Cart Screen

<img width="430" height="932" alt="image" src="https://github.com/user-attachments/assets/ef1db5d2-e4c9-4bca-8a35-eb59d8d8deed" />


## Performed by

Andrii ([Kossman](https://github.com/stkossman)) Stavskyi
