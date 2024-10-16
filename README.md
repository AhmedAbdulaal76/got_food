# Overview

## Got Food?

A recipe sharing app built for browsing, sharing, and storing recipes posted by other users. Discover the top worldwide recipes everyday!

Key Features:

- A page displaying a list of recipes published by others. Each recipe can be extended to display its specific details and ingredients.
- The ability to filter posts according to calorie limitations, meal type, preparation time, and more, in order to find the perfect recipe.
- The ability to favourite recipes and store them in the favourites page for easy access.
- A profile where users can post their own recipes and view other users’ favorited recipes.
- Dark/Light mode support for accessibility.

# Project Structure

## Feature based

we will focus on features instead of UI, the feature-first approach lets us structure our project around the **functional requirements** of our app.

### Whats a feature?

a feature is a **functional requirement** that helps the user **complete a given task**.

- authenticate
- manage the favorite recipes
- search
- view all popular recipes
- leave a review

## MVVM

**Model–View–ViewModel** (**MVVM**) is a very established architectural pattern when it’s come to software development.

### Model/Service (Data or application service)

The model/service represents a single source of truth that carries the real-time fetch data or database-related queries.

This layer can contain business logic, code validation, etc. This layer interacts with ViewModel for local data or for real-time. Data are given in response to ViewModel.

### ViewModel (Controller)

ViewModel is the mediator between View and Model, which accept all the user events and request that to Model for data. Once the Model has data then it returns to ViewModel and then ViewModel notify that data to View.

ViewModel can be used by multiple views, which means a single ViewModel can provide data to more than one View.

### View (UI)

The view is where the user is interacting with Widgets that are shown on the screen. These user events request some actions which navigate to ViewModel, and the rest of ViewModel does the job. Once ViewModel has the required data then it updates View.

Now, we will go through the example which will demonstrate MVVM architecture, for notifying data we will use the Provider state mechanism.

## Mixing both

when mixing both, we will end up with a structure as the following:

```
lib/
│
├── common/
│   ├── models/                   # Reusable data models across features
│   ├── services/                 # General services (e.g., API services, Database services)
│   ├── utils/                    # Utility classes (e.g., constants, helpers, extensions)
│   ├── widgets/                  # Reusable UI components
│   └── providers/                # Global providers for state management
│       └── providers.dart
│
├── features/
│   ├── authentication/           # Authentication feature
│   │   ├── service/
│   │   │   └── auth_service.dart
│   │   ├── view/
│   │   │   ├── login_screen.dart
│   │   │   └── signup_screen.dart
│   │   └── viewmodel/
│   │       └── auth_viewmodel.dart
│   │
│   ├── favorite_recipes/         # Favorite Recipes feature
│   │   ├── service/
│   │   │   └── favorites_service.dart
│   │   ├── view/
│   │   │   └── favorites_screen.dart
│   │   └── viewmodel/
│   │       └── favorites_viewmodel.dart
│   │
│   ├── search/                   # Search feature
│   │   ├── service/
│   │   │   └── search_service.dart
│   │   ├── view/
│   │   │   └── search_screen.dart
│   │   └── viewmodel/
│   │       └── search_viewmodel.dart
│   │
│   ├── popular_recipes/          # Popular Recipes feature
│   │   ├── service/
│   │   │   └── popular_recipes_service.dart
│   │   ├── view/
│   │   │   └── popular_recipes_screen.dart
│   │   └── viewmodel/
│   │       └── popular_recipes_viewmodel.dart
│   │
│   └── reviews/                  # Review feature
│       ├── service/
│       │   └── review_service.dart
│       ├── view/
│       │   └── review_screen.dart
│       └── viewmodel/
│           └── review_viewmodel.dart
│
└── main.dart                      # Entry point of the application
```
