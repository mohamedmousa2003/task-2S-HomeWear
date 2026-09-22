# Odoo Flutter Mobile Application

A Flutter mobile application integrated with **Odoo ERP** using **JSON-RPC**.
The application provides authentication, customer management, customer search, customer profile updates, and sales order management for internal users.

---

## 📱 Overview

This project was developed as a Flutter technical task with a focus on:

* Clean Architecture
* Separation of concerns
* Reusable components
* Odoo JSON-RPC integration
* State management using Cubit
* Secure authentication handling
* Offline customer caching
* Responsive and maintainable UI

The application communicates directly with an Odoo instance to retrieve and update business data.

---

## ✨ Features

### 🔐 Authentication

* Login using Odoo username and password.
* Authentication through Odoo JSON-RPC.
* Handles invalid credentials and API errors.
* Stores login credentials securely when **Remember Me** is enabled.
* Uses the authenticated Odoo `uid` for subsequent requests.

### 👥 Customer Management

* Fetches customers from Odoo `res.partner`.
* Only customers with:

```text
customer_rank > 0
```

are displayed.

* Displays:

    * Customer Name
    * Phone
    * City
    * Email

### 🔎 Customer Search

* Search customers by name.
* Instant local filtering.
* Clear search functionality.
* Displays an appropriate empty state when no customer matches the search.

### 👤 Customer Details

Displays customer information including:

* Name
* Phone
* Email
* City / Address information

The customer phone number can be updated directly from the application and synchronized with Odoo.

### 📦 Sales Orders

Sales order functionality is available for Odoo internal users.

The application checks whether the authenticated user belongs to:

```text
base.group_user
```

If the user is an internal user, the **Sales Orders** section becomes available.

Sales Orders include:

* Order Number
* Customer
* Order Date
* Status
* Total Amount

### 📄 Sales Order Details

The details screen provides:

* Order information
* Customer information
* Order status
* Products
* Quantity
* Unit price
* Subtotal
* Total amount

### ✅ Confirm Sales Order

For quotations and quotation-sent orders, internal users can confirm the sales order directly from the application.

The application calls Odoo:

```text
sale.order → action_confirm
```

and handles both success and failure states.

### 📴 Offline Handling

Customer data can be cached locally using Hive CE.

When the remote Odoo request fails, the application can fall back to locally cached customer data.

---
<table>

<td><img width="1125" height="2436" alt="Login" src="https://github.com/user-attachments/assets/5991e636-1661-4577-bb73-d2e723120291" /></td>
<tr><img width="1280" height="2856" alt="Customer List " src="https://github.com/user-attachments/assets/30850a18-1d58-43ab-a56e-135146e25037" /></td>
<tr><img width="1280" height="2856" alt="Search" src="https://github.com/user-attachments/assets/a50a2036-03d4-488a-88d0-b7c55aa7ea7f" /></td>
<tr><img width="1280" height="2856" alt="Update Phone" src="https://github.com/user-attachments/assets/f78d1dcb-31fb-4526-bc42-0b6ebdf7f9d3" /></td>


</tr>
</table>

<table>

<td><img width="1125" height="2436" alt="Login" src="https://github.com/user-attachments/assets/5991e636-1661-4577-bb73-d2e723120291" /></td>
<td><img width="1280" height="2856" alt="Sales Orders" src="https://github.com/user-attachments/assets/f7b901be-d698-4656-bb63-894243b7ab4b" /></td>
<td><img width="1280" height="2856" alt="Sales Orders Inform" src="https://github.com/user-attachments/assets/be945b4c-a69d-4fd2-90a4-2304af9ff2f8" /></td>
<td><img width="1280" height="2856" alt="Sales Orders Inform" src="https://github.com/user-attachments/assets/9884dfd4-68dc-4846-bc09-28470c1009d3" /></td>

</tr>
</table>
# 🏗️ Architecture

The project follows **Clean Architecture** with a feature-based structure.

```text
lib/
│
├── config/
│   └── di/
│
├── core/
│   ├── errors/
│   ├── helpers/
│   ├── network/
│   ├── storage/
│   ├── utils/
│   └── values/
│
├── features/
│   │
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── home/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   └── sales_orders/
│       ├── data/
│       ├── domain/
│       └── presentation/
│
└── main.dart
```

Each feature is separated into three main layers:

### Data Layer

Responsible for:

* API communication
* JSON models
* Remote data sources
* Local data sources
* Repository implementations

### Domain Layer

Contains:

* Entities
* Repository contracts
* Use Cases

The domain layer is independent from Flutter UI and API implementation details.

### Presentation Layer

Contains:

* Screens
* Cubits
* States
* Widgets

Cubit is used for state management and keeping business logic outside the UI.

---

# 🔄 Application Flow

## Authentication

```text
Login Screen
     │
     ▼
LoginUseCase
     │
     ▼
AuthRepository
     │
     ▼
AuthRemoteDataSource
     │
     ▼
Odoo JSON-RPC
     │
     ▼
Authenticated User
     │
     ▼
Customer List
```

---

## Customer Flow

```text
Customer List
      │
      ├── Search Customer
      │
      └── Customer Details
              │
              ▼
        Update Phone
              │
              ▼
        Odoo res.partner
```

---

## Internal User Flow

```text
Login
  │
  ▼
Check Internal User
  │
  ▼
res.users.has_group()
  │
  ├── false → Customer List only
  │
  └── true
       │
       ▼
   Sales Orders
       │
       ▼
 Sale Order Details
       │
       ▼
 Confirm Order
       │
       ▼
sale.order.action_confirm()
```

---

# 🔌 Odoo Integration

The application communicates with Odoo through its **JSON-RPC API**.

### Authentication

```text
service: common
method: login
```

### Customers

```text
model: res.partner
method: search_read
```

with:

```text
customer_rank > 0
```

### Update Customer

```text
model: res.partner
method: write
```

### Check Internal User

```text
model: res.users
method: has_group
```

with:

```text
base.group_user
```

### Sales Orders

```text
model: sale.order
method: search_read
```

### Confirm Sales Order

```text
model: sale.order
method: action_confirm
```

---

# 🛠️ Tech Stack

| Technology           | Usage                           |
| -------------------- | ------------------------------- |
| Flutter              | Mobile application              |
| Dart                 | Programming language            |
| Flutter Bloc / Cubit | State management                |
| Dio                  | HTTP client                     |
| Retrofit             | API abstraction                 |
| JSON Serializable    | JSON serialization              |
| GetIt                | Dependency injection            |
| Injectable           | Dependency injection generation |
| Equatable            | State/entity comparison         |
| Hive CE              | Local caching                   |
| Connectivity Plus    | Network connectivity            |
| Odoo JSON-RPC        | ERP integration                 |

---

# 📦 Main Dependencies

Example dependencies used by the project:

```yaml
dependencies:
  flutter_bloc:
  dio:
  retrofit:
  json_annotation:
  equatable:
  get_it:
  injectable:
  hive_ce:
  hive_ce_flutter:
  connectivity_plus:
```

Generated files are created using:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

# ⚙️ Requirements

Before running the project, make sure you have:

* Flutter SDK
* Dart SDK
* Android Studio or another Flutter-compatible IDE
* Android SDK
* A running Odoo instance
* Valid Odoo database credentials

---

# 🚀 Getting Started

## 1. Clone the Repository

```bash
git clone <YOUR_GITHUB_REPOSITORY_URL>
```

Navigate to the project:

```bash
cd task2shomewear
```

---

## 2. Install Dependencies

```bash
flutter pub get
```

---

## 3. Configure Odoo

Set the Odoo endpoint in the project configuration.

Example:

```text
https://your-odoo-server.com/jsonrpc
```

The application requires:

```text
Database Name
Odoo User ID
Password
```

The `uid` is returned by Odoo after successful authentication.

---

## 4. Generate Code

Run:

```bash
dart run build_runner build --delete-conflicting-outputs
```

---

## 5. Run the Application

```bash
flutter run
```

---

# 🔑 Odoo Permissions

For the complete functionality, the Odoo user should have the required permissions for:

### Customers

```text
res.partner
```

### Users

```text
res.users
```

### Sales Orders

```text
sale.order
```

Internal users are detected using:

```text
base.group_user
```

---

# 🧪 Example Odoo JSON-RPC Request

Customer request:

```json
{
  "jsonrpc": "2.0",
  "method": "call",
  "params": {
    "service": "object",
    "method": "execute_kw",
    "args": [
      "odoo_flutter",
      2,
      "admin123",
      "res.partner",
      "search_read",
      [
        [
          ["customer_rank", ">", 0]
        ]
      ],
      {
        "fields": [
          "id",
          "name",
          "phone",
          "city",
          "email"
        ],
        "limit": 50
      }
    ]
  },
  "id": 1
}
```

---

# 🔐 Security Considerations

The application avoids hard-coding user credentials inside API requests.

Authentication information is passed dynamically after login.

When **Remember Me** is enabled, credentials are stored using secure local storage.

For production environments, it is recommended to:

* Use HTTPS.
* Avoid storing plain-text passwords where possible.
* Use secure credential/token storage.
* Keep Odoo credentials outside the source code.
* Use environment-specific configuration.
* Apply appropriate Odoo access rights.

---

# 📂 Feature Structure

## Authentication

```text
features/auth/
├── data/
│   ├── data_source/
│   ├── model/
│   └── repository/
│
├── domain/
│   ├── entities/
│   ├── repository/
│   └── use_cases/
│
└── presentation/
    ├── manager/
    ├── pages/
    └── widgets/
```

## Customers

```text
features/home/
├── data/
├── domain/
└── presentation/
```

## Sales Orders

```text
features/sales_orders/
├── data/
│   ├── data_source/
│   ├── model/
│   └── repository/
│
├── domain/
│   ├── entities/
│   ├── repository/
│   └── use_cases/
│
└── presentation/
    ├── cubit/
    ├── pages/
    └── widgets/
```

---

# 🎯 Design Principles

The project follows these principles:

* Separation of concerns
* Dependency inversion
* Single responsibility
* Reusable widgets
* Feature-based architecture
* Repository pattern
* Use Case pattern
* Immutable entities
* Explicit loading/success/error states
* Centralized dependency injection
* API abstraction through Retrofit

---

# 📌 Current Scope

Implemented:

* [x] Odoo Authentication
* [x] Customer List
* [x] Customer Search
* [x] Customer Details
* [x] Update Customer Phone
* [x] Customer Email
* [x] Local Customer Cache
* [x] Internal User Detection
* [x] Sales Orders List
* [x] Sales Order Details UI
* [x] Sales Order Confirmation
* [x] Error Handling
* [x] Clean Architecture
* [x] Dependency Injection

---

# 🔮 Possible Improvements

Future improvements could include:

* Offline edit queue and automatic synchronization
* Pagination for large customer/order datasets
* Advanced customer filtering
* Sales order filtering by status/date
* Pull-to-refresh
* Better session/token management
* Automated unit and widget tests
* CI/CD pipeline
* More detailed Odoo error mapping
* Dedicated Sale Order Details API for loading order lines independently

---

# 👨‍💻 Developer

**Mohamed Mousa**

Flutter Developer

Built with Flutter and integrated with Odoo ERP using JSON-RPC.

---

## License

This project was developed for technical evaluation and demonstration purposes.
