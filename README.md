# 📱 GithubAdminProject

A modular iOS application designed with **Clean Architecture** principles. This approach ensures scalability, testability, and long-term maintainability.

---

## 🧱 Architecture Overview

The project is organized into multiple modules, each with a clearly defined responsibility:

### ✅ Presentation module

- Manages the UI and handles user interactions.
- Communicates with `UseCases` to trigger business logic.
- Includes:
  - Views (Main Screens and Reusable Components)
  - ViewModels (Combine-based)
  - Design System (spacing, sizes, etc.)
  - Utilities and Extensions
  - Router (for navigation)

### ✅ Domain module

- Contains platform-independent business logic.
- Free from external dependencies.
- Includes:
  - Entities
  - UseCases
  - Policy Logic (e.g., pagination rules)
  - Repository Protocols (defined interfaces for data interaction)

### ✅ Data module

- Handles data operations from both local and remote sources.
- Implements the interfaces defined in the domain layer.
- Includes:
  - Repository Implementations
  - Data Sources:
    - Local (Realm)
    - Remote (API requests using URLSession)
  - Mappers (convert between data and domain models)
  - Mock Data
  - Utilities

---

## 📊 Layer Dependency Graph

```
+--------------------+
|  Presentation      |
+--------+-----------+
         |
         v
+--------+-----------+
|  Domain            |
+--------+-----------+
         |
         v
+--------+-----------+
|  Data              |
+--------------------+
```

- The **Presentation** layer depends on the **Domain** layer.
- The **Domain** layer is independent and defines contracts.
- The **Data** layer depends on the **Domain** layer to implement contracts.

---

## 🧪 Testing Strategy

Testing is organized per module to ensure separation of concerns and maintainable coverage.

### 🧩 PresentationTests

- Tests ViewModels, CountFormatter, ImageCache.
- Uses mock UseCases for isolation.

### 🧠 DomainTests

- Unit tests for UseCases domain-specific logic.
- All dependencies are mocked.
- Focuses solely on business logic.

### 📦 DataTests

- Tests components of the data layer including:
  - Repository implementations
  - Local persistence logic
  - Data-to-domain Mappers
- Uses mock network responses and in-memory stores.
- Ensures accurate transformation between data models and domain models.

---

By following this structure, GithubAdminProject remains modular, testable, and ready to scale as feature requirements grow.
