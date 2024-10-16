import 'package:cointacao/services/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final AuthService _authService;

  AuthRepository(this._authService);

  Future<String?> signIn(String email, String password) async {
    try {
      User? user = await _authService.signIn(email, password);
      return user?.uid;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      User? user = await _authService.register(email, password);
      return user?.uid;
    } on FirebaseAuthException {
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  User? getUser() {
    return _authService.getUser();
  }
}
