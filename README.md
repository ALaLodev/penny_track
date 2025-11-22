# 💰 Penny Track

**Penny Track** es una aplicación móvil de gestión financiera personal desarrollada con **Flutter**. Este proyecto no es solo un gestor de gastos; es una implementación de referencia de una arquitectura de software robusta, escalable y segura, con un diseño UI/UX premium ("Dark Fintech").

La aplicación permite registrar movimientos financieros, visualizar balances mensuales mediante gráficos interactivos y garantiza la privacidad de los datos multi-usuario mediante una sincronización inteligente entre autenticación en la nube y persistencia local.

---

## 📱 Galería

<p align="center"> 
    <img src="/lib/assets/screenshots/Login.png" alt="Login Screen" width="20%" style="margin-right: 40dp">  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 10 non-breaking spaces -->  
  <img src="/lib/assets/screenshots/Create_Acount2.png" alt="Create acount Screen" width="20%" style="margin-right: 40dp">  
   &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 10 non-breaking spaces -->  
  <img src="/lib/assets/screenshots/Home.png" alt="Home Screen" width="20%"> 
  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <!-- 10 non-breaking spaces -->  
  <img src="/lib/assets/screenshots/Incomes.png" alt="Incomes Screen" width="20%"><br>
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

- recupera la sesión,
- permite el acceso,
- degrada el servicio elegantemente en lugar de bloquear al usuario.

---

## 4. Optimización de Rendimiento y UI

- Uso estricto de **constructores `const`** para evitar reconstrucciones innecesarias.
- Implementación de **FittedBox** y **VisualDensity** para una UI responsiva en diferentes pantallas.
- Configuración avanzada del tema (`scrolledUnderElevation: 0`) para mantener la consistencia visual del modo oscuro al hacer scroll.