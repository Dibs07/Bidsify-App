import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? user;
  User? get currentUser{
    return user;
  }
  AuthService() {
    _auth.authStateChanges().listen(authStateStreamChange);
  } 
  Future<bool> register(String email, String password) async {
    try {
      final credentials = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user != null) {
        user=credentials.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  Future<bool> login(String email, String password) async {
    try {
      final credentials = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credentials.user != null) {
        user=credentials.user;
        return true;
      }
    } catch (e) {
      print(e);
    }
    return false;
  }
  Future<bool> logout () async {
    try {
      await _auth.signOut();
      return true;
    } catch (e) {
      print(e);
    }
    return false;
  }
  void authStateStreamChange(User? userc) {
    user = userc;
  }
  

Future<UserCredential> signInWithGoogle() async {
  final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );
  return await FirebaseAuth.instance.signInWithCredential(credential);
}
}