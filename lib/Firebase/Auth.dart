import 'package:desfood/Ekranlar/KayitOl.dart';
import 'package:desfood/Ekranlar/Login.dart';
import 'package:flutter/material.dart';
class Authentication extends StatefulWidget {
  const Authentication({ Key? key }) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  bool isToggle=false;
  void toggleScreen(){
    setState(() {
      isToggle=! isToggle;

    });
  }
  @override
  Widget build(BuildContext context) {
   if(isToggle){
     return KayitOl(toggleScreen: toggleScreen);
   }else{
     return Login(toggleScreen:toggleScreen);
   }
  }
}