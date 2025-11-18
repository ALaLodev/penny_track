import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Asegúrate de que los scopes estén bien (necesario para versiones nuevas)
  final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  @override
  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  @override
  Future<User?> signInWithEmail(String email, String password) async {
    // 💡 SIN TRY/CATCH AQUÍ. Dejamos que el error suba al Cubit.
    final credential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  @override
  Future<User?> signInWithGoogle() async {
    // 💡 SIN TRY/CATCH AQUÍ.
    // Si ocurre el error de Pigeon, subirá crudo y el Cubit lo interceptará.

    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null; // Usuario canceló

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final UserCredential userCredential = await _firebaseAuth
        .signInWithCredential(credential);
    return userCredential.user;
  }

  @override
  Future<User?> signUpWithEmail(String email, String password) async {
    final credential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    return credential.user;
  }

  @override
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
  }
}
