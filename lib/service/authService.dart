import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

//Conexion avec google
  Future<UserCredential> signInWithGoogle() async {
    //Détecter le flux d'authentification
    final GoogleSignInAccount? googltUser = await _googleSignIn.signIn();
    //obtenir les détails d'autorisation de la demande
    final googleAuth = await googltUser!.authentication;
    //créer un nouvel identifiant
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    //renvoyer l'identifiant de user
    return await _auth.signInWithCredential(credential);
  }

  //user's state in reel time
  Stream<User?> get user => _auth.authStateChanges();
}
