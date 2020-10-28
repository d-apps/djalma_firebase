import 'package:firebase_core/firebase_core.dart';

class FirebaseHelper {

  Future init() async {

    await Firebase.initializeApp();

  }


}