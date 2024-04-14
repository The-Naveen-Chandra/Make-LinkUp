import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  // google sign in

  signInWithGoogle() async {
    // begin interactive sign in processing
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // obtain auth details from request
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    // create a new credential for user
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    // finally, lets sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}
