import 'package:firebase_auth/firebase_auth.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;


Future<String> registerWithEmailAndPassword(String email, String password) async {
  try {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return null;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      return 'The password provided is too weak.';
    } else if (e.code == 'email-already-in-use') {
      return 'The account already exists for that email.';
    }
    return e.message;
  } catch (e) {
    return e.toString();
  }
}

Future<String> signInWithEmailAndPassword(
    String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    User user = result.user;
    return null;
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      return 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      return 'Wrong password provided for that user.';
    }
    return e.message;
  } catch (e) {
    return e.toString();
  }
}





// import 'package:firebase_auth/firebase_auth.dart';

// final FirebaseAuth _auth = FirebaseAuth.instance;
// // Sign up with email and password
// Future<UserCredential> signUpWithEmail(String email, String password) async {
//   try {
//     UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

// // Sign in with email and password
// Future<UserCredential> signInWithEmail(String email, String password) async {
//   try {
//     UserCredential userCredential = await _auth.signInWithEmailAndPassword(
//       email: email,
//       password: password,
//     );
//     return userCredential;
//   } catch (e) {
//     print(e);
//     return null;
//   }
// }

// // Sign out
// Future<void> signOut() async {
//   await _auth.signOut();
// }
