// @dart=2.9
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthService with ChangeNotifier {
  bool _isloading = false;
 String _errorMessage;
  bool get isloading => _isloading;
  String get errorMessage => _errorMessage;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future kayitolmethod(String email, String sifre) async {
   
    try {
       setloading(true);
      UserCredential authResult = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: sifre);
      User user = authResult.user;
      setloading(false);
      return user;
    } on SocketException {
      setloading(false);
      setMessage("Internet Bağlantınızı Kontrol Ediniz!!");
    } catch (e) {
      setloading(false);
      print(e);
      setMessage("Bu Email Adresi Kullanılıyor!");
    }
    notifyListeners();
  }

    Future girismethod(String email, String sifre) async {
    
    try {
      setloading(true);
      UserCredential authResult = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: sifre);
      User user = authResult.user;
      setloading(false);
      return user;
    } on SocketException {
      setloading(false);
      setMessage("Internet Bağlantınızı Kontrol Ediniz!!");
    } catch (e) {
      setloading(false);
      print(e);
      setMessage(e.message);
    }
    notifyListeners();
  }

    
    Future cikismethod() async {
   await firebaseAuth.signOut();
  }

  void setloading(val) {
    _isloading = val;
    notifyListeners();
  }

  void setMessage(message) {
    _errorMessage = message;
    notifyListeners();
  }
Stream<User> get user=>firebaseAuth.authStateChanges().map((event) => event);
}


