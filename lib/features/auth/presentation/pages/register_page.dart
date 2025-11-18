import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/config/router.dart';
import '../cubits/auth_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>(); // Para validar el formulario

  void _onRegisterPressed() {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();

      // Llamamos al cubit para registrar
      context.read<AuthCubit>().register(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          // Si el registro funciona y loguea automáticamente, vamos al Home
          context.go(AppRoutes.home);
        } else if (state is AuthError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: colors.error,
            ),
          );
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            // --- CABECERA ---
            Expanded(
              flex: 4,
              child: Container(
                width: double.infinity,
                color: Theme.of(context).scaffoldBackgroundColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person_add_alt_1_rounded,
                      size: 80,
                      color: colors.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'CREAR CUENTA',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: colors.onSurface,
                        letterSpacing: 1.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Únete a Penny Track',
                      style: TextStyle(color: Colors.grey[500], fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            // --- FORMULARIO ---
            Expanded(
              flex: 5,
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
                decoration: BoxDecoration(
                  // Color de tarjeta del tema (Gris Charcoal)
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(40),
                    topRight: Radius.circular(40),
                  ),
                ),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Email
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Correo Electrónico',
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Obligatorio';
                            if (!value.contains('@')) return 'Email no válido';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Contraseña
                        TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            labelText: 'Contraseña',
                            prefixIcon: Icon(Icons.lock_outline),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty)
                              return 'Obligatorio';
                            if (value.length < 6) return 'Mínimo 6 caracteres';
                            return null;
                          },
                        ),
                        const SizedBox(height: 20),

                        // Confirmar Contraseña
                        TextFormField(
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            labelText: 'Confirmar Contraseña',
                            prefixIcon: Icon(Icons.lock_reset),
                          ),
                          obscureText: true,
                          validator: (value) {
                            if (value != _passwordController.text) {
                              return 'Las contraseñas no coinciden';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 40),

                        // Botón Registrarse
                        ElevatedButton(
                          onPressed: _onRegisterPressed,
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            backgroundColor: colors.primary,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text(
                            'REGISTRARSE',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Volver al Login
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text("¿Ya tienes cuenta?"),
                            TextButton(
                              onPressed: () {
                                context.pop();
                              },
                              child: Text(
                                'Inicia Sesión',
                                style: TextStyle(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
