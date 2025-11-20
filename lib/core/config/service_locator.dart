import 'package:get_it/get_it.dart';
import 'package:penny_track/core/data/datasources/app_database.dart';

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

// 💡 --- AUTH ---
import 'package:penny_track/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:penny_track/features/auth/domain/repositories/auth_repository.dart';
import 'package:penny_track/features/auth/presentation/cubits/auth_cubit.dart';

final sl = GetIt.instance;

Future<void> initLocator() async {
  // --- CORE ---
  sl.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // --- GASTOS ---
  sl.registerLazySingleton<GastoRepository>(() => GastoRepositoryImpl(sl()));
  sl.registerLazySingleton(() => GetGastosUseCase(sl()));
  sl.registerLazySingleton(() => SaveGastoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteGastoUseCase(sl()));
  sl.registerLazySingleton(() => GetGastosByRangeUseCase(sl()));

  // --- INGRESOS ---
  sl.registerLazySingleton<IngresoRepository>(
    () => IngresoRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => GetIngresosUseCase(sl()));
  sl.registerLazySingleton(() => SaveIngresoUseCase(sl()));
  sl.registerLazySingleton(() => DeleteIngresoUseCase(sl()));
  sl.registerLazySingleton(() => GetIngresosByRangeUseCase(sl()));

  // 💡 --- AUTH ---
  // Repositorio de Auth
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl());

  // Auth Cubit
  sl.registerFactory(() => AuthCubit(sl()));

  // --- PRESENTATION (CUBITS) ---
  sl.registerFactory(
    () => ListaGastosCubit(
      getGastosUseCase: sl(),
      saveGastoUseCase: sl(),
      deleteGastoUseCase: sl(),
      getGastosByRangeUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ListaIngresosCubit(
      getIngresosUseCase: sl(),
      saveIngresoUseCase: sl(),
      deleteIngresoUseCase: sl(),
      getIngresosByRangeUseCase: sl(),
    ),
  );
}
