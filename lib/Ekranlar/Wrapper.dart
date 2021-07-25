import 'package:desfood/Ekranlar/Anasayfa.dart';
import 'package:desfood/Ekranlar/Login.dart';
import 'package:desfood/Firebase/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class Wrapper extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    final user =Provider.of<User>(context);
    if(user!=null){
     return AnasayfaPage();
    }else{
      return Authentication();
    }
    
  }
}