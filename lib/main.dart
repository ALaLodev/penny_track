import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/config/service_locator.dart' as di;
import 'core/config/router.dart';
import 'features/gastos/presentation/cubits/lista_gastos_cubit.dart';
import 'features/ingresos/presentation/cubits/lista_ingresos_cubit.dart';
import 'core/config/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.initLocator();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // ENVOLVEMOS LA APP CON MultiBlocProvider
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              sl<ListaGastosCubit>()
                ..cargarGastos(), // Cargamos gastos al inicio
        ),
        BlocProvider(
          create: (context) =>
              sl<ListaIngresosCubit>()
                ..cargarIngresos(), // Cargamos ingresos al inicio
        ),
      ],

      child: MaterialApp.router(
        routerConfig: appRouter,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        title: 'Gestor de Gastos',
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
