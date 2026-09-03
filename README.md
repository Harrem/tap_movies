# 🎬 Tap Movies

A Flutter movie discovery app powered by the [TMDB API](https://www.themoviedb.org/). Browse now-playing, upcoming, and top-rated films, dive into full movie details, watch trailers, and save favourites to a local watchlist.

---

## Features

- **Home** — Carousels for Now Playing, Upcoming, and Top Rated movies
- **Movie Detail** — Full details, backdrop gallery, trailers (opens YouTube/browser), similar & recommended movies
- **Search** — Live movie search via TMDB
- **Watchlist** — Offline-persisted personal watchlist
- **Dark / Light Theme** — User-toggle with persistence across restarts
- **Connectivity Banner** — Animated banner on network drop/restore

---

## Tech Stack

| Layer | Technology |
|---|---|
| State Management | [GetX](https://pub.dev/packages/get) (`RxList`, `RxBool`, `RxString`, `Obx`) |
| HTTP Client | [Dio](https://pub.dev/packages/dio) with interceptors |
| Local DB | [sqflite](https://pub.dev/packages/sqflite) |
| Theme Persistence | [shared_preferences](https://pub.dev/packages/shared_preferences) |
| Skeletons | [skeletonizer](https://pub.dev/packages/skeletonizer) |
| Carousels | [carousel_slider](https://pub.dev/packages/carousel_slider) |
| Fonts | [google_fonts](https://pub.dev/packages/google_fonts) |
| URL Launch | [url_launcher](https://pub.dev/packages/url_launcher) |
| Connectivity | [internet_connection_checker](https://pub.dev/packages/internet_connection_checker) |
| Env Config | [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) |

---

## Architecture & Key Techniques

### GetX MVC
The project follows a strict **MVC pattern via GetX**:
- `lib/view/` — UI screens (pure widgets, no business logic)
- `lib/controller/` — GetX controllers holding all reactive state & logic
- `lib/model/` — Plain Dart data models with `fromJson` / `toJson`
- `lib/core/` — Services (`ApiService`, `SqliteService`) and helpers

Controllers are registered in `AppBindings` using `Get.put` (permanent singletons) or `Get.lazyPut` (on-demand, with `fenix: true` for auto-recreation after disposal).

### Skeleton Loading via Fake Data
Instead of separate loading widgets, each controller pre-populates its reactive lists with **fake placeholder objects** on `onInit`. `skeletonizer` renders them as shimmer skeletons automatically until real data arrives — no conditional widget switching needed.

### Dio Interceptors + Typed Error Handler
`ApiService` (a `GetxService`) configures Dio with an `InterceptorsWrapper` for request/response logging. All `DioException`s are normalised by `DioErrorHandler` (a factory-pattern helper) into human-readable messages, keeping error surfacing consistent across the app.

### SQLite Watchlist
`SqliteService` (permanent `GetxService`) manages an SQLite database for offline watchlist persistence. `WatchlistController` wraps it with a reactive `RxList<MovieModel>` so the UI updates instantly on add/remove without manual refresh.

### Connectivity-Aware Banner
`ConnectivityController` listens to the `InternetConnectionChecker` status stream. It exposes `isOffline` and `showSuccessBanner` observables — the success banner auto-hides after 2 seconds via an internal `Timer`, giving clear feedback on reconnection.

### Theme with Persistence
`ThemeController` stores the dark/light preference in `SharedPreferences` and exposes a `ThemeMode` getter, keeping the chosen theme consistent across cold starts.

### Extension Methods
`ImageExt` on `Image` adds `.withDefaultOnError()` — a drop-in wrapper that shows a branded gradient placeholder both during image loading and on network/decode errors.

---

## Setup

1. **Clone** the repo and run `flutter pub get`.
2. Create a `.env` file at the project root (see `.env_example`):
   ```
   API_KEY=your_tmdb_api_key_here
   ```
3. Run with `flutter run`.

> Get your free API key at [https://www.themoviedb.org/settings/api](https://www.themoviedb.org/settings/api)

---

## AI Assistance Disclosure

The animated splash screen (`lib/view/splash_view.dart`) was designed with the assistance of an AI coding tool. This includes the staggered animation sequence, glow orb layout, pulse ring effect, and progress bar. All other screens, controllers, services, models, and architectural decisions were written by hand.
