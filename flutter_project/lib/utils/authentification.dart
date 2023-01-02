import 'package:firebase_auth/firebase_auth.dart';

class Authentification{
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static User? currentFirebaseUser;

  static Future<dynamic> signUp({required String email, required String password}) async {
    try{
     // UserCredential newAccount = ...として作成したユーザーの情報を取得する
     UserCredential newAccount =  await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      print("firebaseAuth認証完了");
      //作成したユーザーを返す
      return newAccount;
    }on FirebaseAuthException catch(e){
      print("firebaseAuth認証エラー");
      return "登録エラー";
    }
  }

  static Future<dynamic> emailSignIn(
      {required String email, required String password}) async{
    try{
      final UserCredential _result = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password);
      currentFirebaseUser = _result.user;
      print("SignIn Completed");
      return true;
    } on FirebaseAuthException catch(e){
      print("SignIn Error");
      return false;
    }
  }
}