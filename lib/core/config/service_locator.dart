import 'package:get_it/get_it.dart';
import 'package:penny_track/core/data/datasources/app_database.dart'; // La DB

// --- GASTOS ---
import 'package:penny_track/domain/repositories/gasto_repository.dart';
import 'package:penny_track/features/gastos/data/repositories/gasto_repository_impl.dart';
import 'package:penny_track/domain/use_cases/get_gastos_use_case.dart';
import 'package:penny_track/domain/use_cases/save_gasto_use_case.dart';
import 'package:penny_track/domain/use_cases/delete_gasto_use_case.dart';
import 'package:penny_track/domain/use_cases/get_gastos_by_range_use_case.dart';
import 'package:penny_track/features/gastos/presentation/cubits/lista_gastos_cubit.dart';

// --- INGRESOS ---
import 'package:penny_track/domain/repositories/ingreso_repository.dart';
import 'package:penny_track/features/ingresos/data/repositories/ingreso_repository_impl.dart';
import 'package:penny_track/domain/use_cases/get_ingresos_use_case.dart';
import 'package:penny_track/domain/use_cases/save_ingreso_use_case.dart';
import 'package:penny_track/domain/use_cases/delete_ingreso_use_case.dart';
import 'package:penny_track/domain/use_cases/get_ingresos_by_range_use_case.dart';

import 'package:penny_track/features/ingresos/presentation/cubits/lista_ingresos_cubit.dart';

final sl = GetIt.instance; //sl = Service Locator

// Función que se llamará en main.dart
Future<void> initLocator() async {
  // --- CORE ---
  // (Usamos LazySingleton para la DB, es mejor que Singleton normal)
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // --- CAPA DATA (Repositorios) ---
  sl.registerLazySingleton<GastoRepository>(() => GastoRepositoryImpl(sl()));
  sl.registerLazySingleton<IngresoRepository>(
    () => IngresoRepositoryImpl(sl()),
  );

  // --- CAPA DOMAIN (Use Cases - Gastos) ---
  sl.registerLazySingleton(() => GetGastosUseCase(sl()));
  sl.registerLazySingleton(() => SaveGastoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteGastoUseCase(sl()));
  sl.registerLazySingleton(() => GetGastosByRangeUseCase(sl()));

  // --- CAPA DOMAIN (Use Cases - Ingresos) ---
  sl.registerLazySingleton(() => GetIngresosUseCase(sl()));
  sl.registerLazySingleton(() => SaveIngresoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteIngresoUseCase(sl()));
  sl.registerLazySingleton(() => GetIngresosByRangeUseCase(sl()));

  // --- CAPA PRESENTATION (Blocs/Cubits) ---

  // Cubit de Gastos
  sl.registerFactory(
    () => ListaGastosCubit(
      getGastosUseCase: sl(),
      saveGastoUseCase: sl(),
      deleteGastoUseCase: sl(),
      getGastosByRangeUseCase: sl(),
    ),
  );

  // Cubit de Ingresos
  sl.registerFactory(
    () => ListaIngresosCubit(
      getIngresosUseCase: sl(),
      saveIngresoUseCase: sl(),
      deleteIngresoUseCase: sl(),
      getIngresosByRangeUseCase: sl(),
    ),
  );
}
