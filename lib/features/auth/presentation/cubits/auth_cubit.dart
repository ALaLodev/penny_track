import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../domain/repositories/auth_repository.dart';

// --- ESTADOS ---
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final User user;
  AuthAuthenticated(this.user);
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;
  AuthError(this.message);
}

// --- CUBIT ---
class AuthCubit extends Cubit<AuthState> {
  final AuthRepository _authRepository;

  AuthCubit(this._authRepository) : super(AuthInitial()) {
    // Listener básico para cambios de sesión
    _authRepository.authStateChanges.listen((User? user) {
      if (user != null && state is! AuthAuthenticated) {
        emit(AuthAuthenticated(user));
      } else if (user == null) {
        emit(AuthUnauthenticated());
      }
    });
  }

  Future<void> loginEmail(String email, String password) async {
    emit(AuthLoading());

    try {
      await _authRepository.signInWithEmail(email, password);
    } catch (e) {
      if (FirebaseAuth.instance.currentUser != null) return;

      String mensaje = "Error desconocido";

      if (e is FirebaseAuthException) {
        mensaje = _mapFirebaseError(e.code);
      } else {
        mensaje = e.toString();
      }

      emit(AuthError(mensaje));
    }
  }

  Future<void> register(String email, String password) async {
    emit(AuthLoading());
    try {
      await _authRepository.signUpWithEmail(email, password);
    } catch (e) {
      if (FirebaseAuth.instance.currentUser != null) return;

      String mensaje = "Error al registrarse";
      if (e is FirebaseAuthException) {
        if (e.code == 'email-already-in-use') {
          mensaje = 'El correo ya está registrado.';
        } else {
          mensaje = _mapFirebaseError(e.code);
        }
      }
      emit(AuthError(mensaje));
    }
  }

  Future<void> loginGoogle() async {
    emit(AuthLoading());
    try {
      await _authRepository.signInWithGoogle();
    } catch (e) {
      if (FirebaseAuth.instance.currentUser != null) return;
      emit(AuthError("No se pudo iniciar sesión con Google."));
    }
  }

  Future<void> logout() async {
    await _authRepository.signOut();
  }

  // Traductor simple de errores
  String _mapFirebaseError(String code) {
    switch (code) {
      case 'user-not-found':
      case 'wrong-password':
      case 'invalid-credential':
        return 'Correo o contraseña incorrectos.';
      case 'invalid-email':
        return 'El correo no es válido.';
      case 'user-disabled':
        return 'Cuenta deshabilitada.';
      case 'network-request-failed':
        return 'Sin conexión a internet.';
      default:
        return 'Error de acceso ($code).';
    }
  }
}
