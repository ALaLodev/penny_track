# 💰 Penny Track

**Penny Track** is a personal finance management mobile app built with **Flutter**.  
This project is not just an expense manager; it is a reference implementation of a robust, scalable, and secure software architecture with a “Dark Fintech” UI/UX design.

The app allows users to record financial transactions, view monthly balances through interactive charts, and ensures multi-user data privacy through smart synchronization between cloud authentication and local persistence.

---

## 📱 Gallery

<p align="center"> 
    <img src="/lib/assets/screenshots/Login.png" alt="Login Screen" width="20%" style="margin-right: 40dp">  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
    <img src="/lib/assets/screenshots/Create_Acount2.png" alt="Create Account Screen" width="20%" style="margin-right: 40dp">  
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
    <img src="/lib/assets/screenshots/Home.png" alt="Home Screen" width="20%"><br>
    <img src="/lib/assets/screenshots/Incomes.png" alt="Incomes Screen" width="20%">
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
    <img src="/lib/assets/screenshots/Pie.png" alt="Pie Chart Screen" width="20%"> 
    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  
    <img src="/lib/assets/screenshots/Close_session.png" alt="Close Session Screen" width="20%"> 
<p>

---

## 🚀 Main Features

* **Hybrid Authentication:** Full Login and Registration system connected to **Firebase Auth** (Email/Password and Google Sign-In ready), with user-friendly error handling.
* **Transaction Management:** Full CRUD for Income and Expense entries, including categories and custom dates.
* **Reactive Dashboard:** Unified view with instant toggling between expenses and incomes without unnecessary reloads.
* **Data Visualization:** Interactive **Pie Charts** with month-to-month navigation for financial analysis.
* **Multi-User Privacy:** Data architecture designed to isolate local information based on the Firebase UID.
* **Premium UI/UX:** Custom “Onyx & Mint” theme based on Material 3, optimized for dark mode with smooth transitions and visual feedback.

---

## 🏗️ Project Architecture

The project strictly follows **Clean Architecture** principles, organized by **Features**.  
This ensures separation of concerns, decouples business logic from UI, and enhances scalability.

### Directory Structure

lib/
├── core/                  # Cross-cutting configuration (Router, Theme, DI, DB, Utils)
├── domain/                # Pure Business Rules (Entities and Contracts)
├── features/
│   ├── auth/              # Authentication Logic (Cubit, Repo, UI)
│   ├── dashboard/         # Main screen orchestrator and Charts
│   ├── gastos/            # Complete Expenses Feature (Data, Domain, Presentation)
│   └── ingresos/          # Complete Incomes Feature
└── main.dart              # Entry point and dependency injection



---

# 📐 Implemented Design Patterns

The code makes extensive use of proven design patterns to solve common mobile development problems:

## **BLoC / Cubit**
Used for state management. It separates presentation logic from the UI, keeping widgets “dumb” and purely reactive to state changes.

## **Repository Pattern**
Abstracts the data source (Data Layer). The Domain layer doesn't know whether data comes from SQL, REST API, or memory, making it easy to swap sources in the future.

## **Dependency Injection (DI)**
Implemented with **get_it**. Allows injecting dependencies (UseCases inside Cubits, Repositories inside UseCases) in a decoupled way, facilitating unit testing.

## **Adapter / Mapper**
Pattern used to safely transform data between database models (Drift) and pure domain entities.

## **Factory Pattern**
Used in dependency injection to instantiate Cubits on demand.

---

# 💡 Key Technical Highlights

## 1. Relational Database & Migrations
Unlike simple key-value solutions, **Drift** was chosen to maintain relational integrity of financial data.

### **Migration Strategy**
A custom **MigrationStrategy** was implemented in `AppDatabase` to manage schema evolution  
(e.g., adding the `userId` column in version 4) without losing data on existing devices.

---

## 2. Data Security & Isolation
Even though the database is local (SQLite), the app simulates a secure multi-tenant environment.

### **Dependency Injection**
Repositories (`GastoRepositoryImpl`, `IngresoRepositoryImpl`) dynamically obtain the `currentUser.uid` from Firebase Auth.

### **Automatic Filtering**
All read/write queries inject or filter by this `uid`.  
This mathematically guarantees that if two users log in sequentially on the same device,  
they will **never see each other’s data**.

---

## 3. Authentication Robustness ("Safety Net")
Advanced defensive logic was implemented in `AuthCubit` to handle inconsistencies between the native Android layer and Flutter (specifically type conflicts in Pigeon channels).

### **Failsafe Logic**
If an unhandled exception occurs during login but the Firebase session is successfully established in the background, the system performs a safety check that:

- recovers the session.
- grants access.
- gracefully degrades the service instead of blocking the user.

---

## 4. Performance & UI Optimizations

- Strict use of **constructors** to avoid unnecessary widget rebuilds.
- Implementation of **FittedBox** and **VisualDensity** to ensure responsive UI across different screen sizes.
- Advanced theme configuration to maintain dark-mode visual consistency while scrolling.


# 💰 Penny Track

**Penny Track** es una aplicación móvil de gestión financiera personal desarrollada con **Flutter**. Este proyecto no es solo un gestor de gastos; es una implementación de referencia de una arquitectura de software robusta, escalable y segura, con un diseño UI/UX "Dark Fintech".

La aplicación permite registrar movimientos financieros, visualizar balances mensuales mediante gráficos interactivos y garantiza la privacidad de los datos multi-usuario mediante una sincronización inteligente entre autenticación en la nube y persistencia local.

---

## 📱 Galería

<p align="center"> 
    <img src="/lib/assets/screenshots/Login.png" alt="Login Screen" width="20%" style="margin-right: 40dp">  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 10 non-breaking spaces -->  
  <img src="/lib/assets/screenshots/Create_Acount2.png" alt="Create acount Screen" width="20%" style="margin-right: 40dp">  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 10 non-breaking spaces -->  
  <img src="/lib/assets/screenshots/Home.png" alt="Home Screen" width="20%"><br>
  <img src="/lib/assets/screenshots/Incomes.png" alt="Incomes Screen" width="20%">
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 10 non-breaking spaces -->  
  <img src="/lib/assets/screenshots/Pie.png" alt="Pie Screen" width="20%"> 
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 10 non-breaking spaces -->  
  <img src="/lib/assets/screenshots/Close_session.png" alt="Pie Screen" width="20%"> 
<p>


## 🚀 Características Principales

* **Autenticación Híbrida:** Sistema completo de Login y Registro conectado a **Firebase Auth** (Email/Password y soporte preparado para Google Sign-In), con gestión de errores amigable al usuario.
* **Gestión de Movimientos:** CRUD completo para Ingresos y Gastos, categorización y fechas personalizadas.
* **Dashboard Reactivo:** Vista unificada con conmutador (toggle) instantáneo entre gastos e ingresos sin recargas innecesarias.
* **Visualización de Datos:** Gráficos de pastel (**Pie Charts**) interactivos con filtrado temporal (navegación mes a mes) para análisis financiero.
* **Privacidad Multi-usuario:** Arquitectura de datos diseñada para aislar la información localmente basándose en el UID de Firebase.
* **UI/UX Premium:** Tema personalizado "Onyx & Mint" basado en Material 3, optimizado para modo oscuro con transiciones suaves y feedback visual.

---

## 🏗️ Arquitectura del Proyecto

El proyecto sigue estrictamente los principios de **Clean Architecture** organizados por **Features** (Funcionalidades). Esto garantiza la separación de responsabilidades, desacopla la lógica de negocio de la UI y facilita la escalabilidad.

### Estructura de Directorios

lib/
├── core/                  # Configuración transversal (Router, Theme, DI, DB, Utils)
├── domain/                # Reglas de Negocio Puras (Entidades y Contratos)
├── features/
│   ├── auth/              # Lógica de Autenticación (Cubit, Repo, UI)
│   ├── dashboard/         # Orquestador de la pantalla principal y Gráficos
│   ├── gastos/            # Feature completa de Gastos (Data, Domain, Presentation)
│   └── ingresos/          # Feature completa de Ingresos
└── main.dart              # Punto de entrada e inyección de dependencias


# 📐 Patrones de Diseño Implementados

El código hace uso extensivo de patrones de diseño probados para resolver problemas comunes de desarrollo móvil:

## **BLoC / Cubit**
Utilizado para la gestión de estado. Separa la lógica de presentación de la UI, haciendo que los widgets sean "tontos" y puramente reactivos a los cambios de estado.

## **Repository Pattern**
Abstrae la fuente de datos (Data Layer). La capa de Dominio no sabe si los datos vienen de SQL, API REST o memoria, lo que facilita cambiar la fuente de datos en el futuro.

## **Dependency Injection (DI)**
Implementado con **get_it**. Permite inyectar dependencias (UseCases dentro de Cubits, Repositorios dentro de UseCases) de forma desacoplada, facilitando el testing unitario.

## **Adapter / Mapper**
Patrón utilizado para la transformación segura de datos entre modelos de base de datos (Drift) y entidades de dominio puras.

## **Factory Pattern**
Usado en la inyección de dependencias para instanciar Cubits bajo demanda.

---

# 💡 Detalles Técnicos Destacados

## 1. Base de Datos Relacional y Migraciones
A diferencia de soluciones clave-valor simples, se optó por **Drift** para mantener la integridad relacional de los datos financieros.

### **Estrategia de Migración**
Se implementó una estrategia personalizada (**MigrationStrategy**) en la clase `AppDatabase` para manejar la evolución del esquema (ej: la adición de la columna `userId` en la versión 4) sin pérdida de datos en dispositivos existentes.

---

## 2. Seguridad y Aislamiento de Datos (Data Isolation)
Aunque la base de datos es local (SQLite), la aplicación simula un entorno multi-tenant seguro.

### **Inyección de Dependencias**
Los repositorios (`GastoRepositoryImpl`, `IngresoRepositoryImpl`) obtienen dinámicamente el `currentUser.uid` de Firebase Auth.

### **Filtrado Automático**
Todas las consultas de lectura y escritura inyectan o filtran por este `uid`.  
Esto asegura matemáticamente que, si dos usuarios inician sesión secuencialmente en el mismo dispositivo, **nunca verán los datos del otro**.

---

## 3. Robustez en Autenticación ("Red de Seguridad")
Se implementó una lógica defensiva avanzada en el `AuthCubit` para manejar inconsistencias entre la capa nativa de Android y el framework Flutter (específicamente conflictos de tipos en canales Pigeon).

### **Failsafe Logic**
Si ocurre una excepción no controlada durante el proceso de login pero la sesión de Firebase se establece correctamente en segundo plano, el sistema realiza una comprobación de seguridad que:

- recupera la sesión.
- permite el acceso.
- degrada el servicio elegantemente en lugar de bloquear al usuario.

---

## 4. Optimización de Rendimiento y UI

- Uso estricto de **constructores** para evitar reconstrucciones innecesarias.
- Implementación de **FittedBox** y **VisualDensity** para una UI responsiva en diferentes pantallas.
- Configuración avanzada del tema para mantener la consistencia visual del modo oscuro al hacer scroll.
