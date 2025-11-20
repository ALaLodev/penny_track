import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/router.dart';
import '../cubits/auth_cubit.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  // Método para mostrar el diálogo de login por email
  void _showEmailLoginSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          left: 20,
          right: 20,
          top: 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Login con Email',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  context.read<AuthCubit>().loginEmail(
                    _emailController.text.trim(),
                    _passwordController.text.trim(),
                  );
                },
                child: const Text('Entrar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Escuchamos el estado para navegar si el login es exitoso
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          context.go(AppRoutes.home); // Ir al Dashboard
        } else if (state is AuthError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            // --- 1. MITAD SUPERIOR ---
            Expanded(
              flex: 1,
              child: Container(
                width: double.infinity,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Placeholder del Logo
                    Icon(
                      Icons.account_balance_wallet,
                      size: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'PENNY TRACK',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onSurface,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // --- 2. MITAD INFERIOR (BOTONES) ---
            Expanded(
              flex: 1,
              child: Container(
                padding: const EdgeInsets.all(30.0),
                decoration: BoxDecoration(
                  color: Theme.of(
                    context,
                  ).cardTheme.color, // Color de tarjeta oscuro
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Bienvenido de nuevo',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 30),

                    // Botón Login Email
                    ElevatedButton.icon(
                      icon: const Icon(Icons.email_outlined),
                      label: const Text('Login con Email'),
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      onPressed: _showEmailLoginSheet,
                    ),

                    const SizedBox(height: 16),

                    // Botón Login Google
                    OutlinedButton.icon(
                      icon: const Icon(Icons.g_mobiledata, size: 28),
                      label: const Text('Login con Google'),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onPressed: () {
                        context.read<AuthCubit>().loginGoogle();
                      },
                    ),
                    Spacer(),
                    // Texto de registro
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("¿No tienes cuenta?"),
                        TextButton(
                          onPressed: () => context.push(AppRoutes.register),
                          child: const Text('Crea una'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
