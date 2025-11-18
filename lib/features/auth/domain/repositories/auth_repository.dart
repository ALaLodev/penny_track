import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthRepository {
  Future<User?> signInWithEmail(String email, String password);
  Future<User?> signInWithGoogle();
  Future<User?> signUpWithEmail(String email, String password);
  Future<void> signOut();
  Stream<User?>
  get authStateChanges; // Para saber si está logueado en tiempo real
}
