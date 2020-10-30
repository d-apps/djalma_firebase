import 'package:djalma_firebase/src/util/get_firebase_error_message.dart';
import 'package:djalma_firebase/src/widgets/error_snackbar.dart';
import 'package:djalma_firebase/src/widgets/sucess_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class AuthHelper {

  static final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // Sign-up the user and login using it's credentials
  static Future<User> signUp(String email, String pass) async {

    User user;

    try{

      UserCredential userCredential = await firebaseAuth.createUserWithEmailAndPassword(email: email, password: pass);

      user = userCredential.user;

    } catch (e){

      print("ERRO SIGNUP: ${e.toString()}");

      errorSnackBar(message: "Falha em cadastrar usuário! Erro: ${getFirebaseErrorMessage(e.toString())}");

      return user;
    }

    return user;

  }

  //
  static Future<bool> login(String email, String pass) async {

    bool res = false;

    try{

      // Try to login with email and password
      await firebaseAuth.signInWithEmailAndPassword(email: email, password: pass);

      successSnackBar(message: "Login realizado com sucesso!");

      res = true;

    } catch (e){

      print("FIREBASE AUTH ERROR: ${e.toString()}");

      errorSnackBar(message: "Falha em realizar o login, erro: ${getFirebaseErrorMessage(e.toString())}");

      return res;

    }

    return res;

  }

  // Create user credentials without login the user
  static Future<User> signUpUserWithoutLogin(String email, String pass) async {
    
    User user;
    
    FirebaseApp app = await Firebase.initializeApp(
      name: "${DateTime.now()}", options: Firebase.app().options
    );
    
    try{
      
      UserCredential userCredential = await FirebaseAuth.instanceFor(app: app)
          .createUserWithEmailAndPassword(email: email, password: pass);

      user = userCredential.user;
      
    } catch (e){

      print("ERROR CREATING USER: ${e.toString()}");

      errorSnackBar(message: "Falha em realizar o login, erro: ${getFirebaseErrorMessage(e.toString())}");

      return user;
      
    }

    return user;
    
  }

  static Future<bool> signOut() async {

    bool res = false;

    try{

      await firebaseAuth.signOut();
      res = true;

    } catch(e){

      print("ERROR TO SIGN OUT: ${e.toString()}");

      errorSnackBar(message: "Falha em deslogar, erro: ${getFirebaseErrorMessage(e.toString())}");

    }


    return res;

  }

  static Future<bool> isLoggedIn() async {

    User user = firebaseAuth.currentUser;

    if(firebaseAuth == null){

      if(kIsWeb){
        user = await firebaseAuth.authStateChanges().first;
      }

    }

    return user != null;

  }

  static Future<void> recoveryPassword(String email) async{

    try{

      await firebaseAuth.sendPasswordResetEmail(email: email);

      successSnackBar(
        message: "O e-mail de recuperação foi enviado com sucesso!",
      );

    } catch(e){

      print("ERROR SENDING RESET PASSWORD: ${e.toString()}");

      errorSnackBar(message: "Falha em enviar e-mail de recuperação de senha, erro: ${getFirebaseErrorMessage(e.toString())}");

    }

  }

}