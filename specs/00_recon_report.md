# System Reconnaissance Report: OldStock-2017 Inventory

## 1. High-Level Overview
The system is a legacy Cordova/PhoneGap hybrid mobile application designed for inventory management. It relies heavily on direct DOM manipulation using jQuery and stores application state in global variables. The architecture is monolithic on the client-side, with business logic tightly coupled to the view layer.

- **Entry Points**:
  - `legacy_src/www/index.html` -> `<body onload="onLoad()">` (Main App)
  - `legacy_src/www/login.html` -> `doLogin()` (Authentication)
- **Key Technologies**: HTML5, CSS3, JavaScript (ES5), jQuery, Cordova Plugins (Camera, BarcodeScanner).

## 2. Architecture Map

### 2.1 File Structure Analysis
```text
legacy_src/
├── www/
│   ├── index.html        # Main Application View & Layout
│   ├── login.html        # Login View with Inline Logic
│   ├── css/              # Styles
│   ├── img/              # Assets
│   └── js/
│       ├── app.js        # CORE LOGIC (The "God Object")
│       ├── cordova_mocks.js # Browser simulation for plugins
│       └── jquery.js     # Vendor Library
```

### 2.2 State Store Mapping
The application uses a fragile global state management strategy:
*   **`window.G_DATA`**: (Array) The master inventory list. Single source of truth but mutable from anywhere.
*   **`window.G_USER_TOKEN`**: (String) Unused in visible logic but declared.
*   **`window.G_LAST_SCAN`**: (String) Stores the result of the last barcode scan.
*   **`window.G_IMG_CACHE`**: (String) Stores base64 image data from the camera. **High Memory Risk**.
*   **`localStorage`**: Stores session data (`isLoggedIn`, `user_id`).

## 3. Module Breakdown (Dependency Tracer)

### 3.1 Core Logic: `legacy_src/www/js/app.js`

#### Function: `fetchInventory()`
*   **Role**: Data Retrieval & Initialization.
*   **Dependencies**: `jQuery.ajax`, `renderList`.
*   **Flow**:
    1.  Show Loading Overlay.
    2.  GET `https://jsonplaceholder.typicode.com/posts`.
    3.  **Writes to**: `G_DATA`.
    4.  **Logic**: Artificially duplicates data (x6) to simulate load.
    5.  Calls `renderList(heavyData)`.

#### Function: `renderList(items)`
*   **Role**: View Rendering.
*   **Dependencies**: None (Pure DOM manipulation).
*   **Flow**:
    1.  Iterates `items`.
    2.  String concatenation of HTML (Performance Hotspot).
    3.  **Writes to**: `#list-container` via `.html()`.
    4.  **Risk**: Full DOM rebuild on every update.

#### Function: `editItem(id, event)` / `deleteItem(id, event)`
*   **Role**: CRUD Operations.
*   **Dependencies**: `findItemById`, `renderList`.
*   **Flow**:
    1.  Stops event propagation.
    2.  Uses `prompt()` or `confirm()` for UI (Blocking).
    3.  Simulates API delay.
    4.  **Mutates**: `G_DATA` directly.
    5.  Calls `renderList(G_DATA)` (Full re-render).

#### Function: `takePhoto()` / `scanBarcode()`
*   **Role**: Native Device Features.
*   **Dependencies**: `navigator.camera`, `cordova.plugins.barcodeScanner`.
*   **Flow**:
    1.  Calls Cordova Plugin.
    2.  **Writes to**: `G_IMG_CACHE` or `G_LAST_SCAN`.
    3.  Directly appends HTML to `#list-container`.

### 3.2 Authentication: `legacy_src/www/login.html`

#### Function: `doLogin()`
*   **Role**: Session Management.
*   **Dependencies**: `localStorage`.
*   **Flow**:
    1.  Validates inputs.
    2.  Simulates server delay.
    3.  **Writes to**: `localStorage` (`isLoggedIn`, `user_id`).
    4.  Redirects to `index.html`.

## 4. Hotspot Analysis (High-Priority Mining Zones)

### 🔴 Zone A: The Rendering Loop (`renderList`)
*   **Reason**: `renderList` reconstructs the entire DOM tree for the list whenever any change occurs. With the artificial data duplication (6x), this is a guaranteed performance bottleneck.
*   **Complexity**: Low logic, high browser cost.
*   **Refactoring Target**: Virtual DOM or fine-grained DOM updates.

### 🔴 Zone B: Global State Mutation
*   **Reason**: `G_DATA` is modified directly by `editItem` and `deleteItem`. There is no state machine or reducer, making race conditions and data inconsistency likely.
*   **Refactoring Target**: State management library (Redux, Context, or Signals).

### 🟠 Zone C: Legacy API Patterns
*   **Reason**: Use of `$.ajax` callbacks and `setTimeout` simulations makes the code hard to read and test. Error handling is primitive (`alert("통신 실패")`).
*   **Refactoring Target**: `async/await`, `fetch` API, and proper Error Boundaries.

### 🟠 Zone D: Inline Event Handlers
*   **Reason**: HTML strings contain `onclick='editItem(...)'`. This requires functions to be in the global scope and breaks strict CSP (Content Security Policy).
*   **Refactoring Target**: `addEventListener` or Framework-based event handling.
