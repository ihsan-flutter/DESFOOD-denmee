// @dart=2.9
import 'package:desfood/Firebase/Auth.dart';
import 'package:desfood/Servisler/Auth_Service/Auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Ekranlar/Wrapper.dart';

void main() => runApp(Giris());

class Giris extends StatelessWidget {
  const Giris({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _init = Firebase.initializeApp();
    return FutureBuilder(
        future: _init,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return ErrorWidget();
          } else if (snapshot.hasData) {
            return MultiProvider(
              providers: [
                ChangeNotifierProvider<AuthService>.value(value: AuthService()),
                StreamProvider<User>.value(
                  value: AuthService().user,
                  initialData: null,
                ),
              ],
              child: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.orange,
                ),
                debugShowCheckedModeBanner: false,
                home: Wrapper(),
              ),
            );
          } else {
            return Loading();
          }
        });
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Icon(Icons.error),
            Text("HATA"),
          ],
        ),
      ),
    );
  }
}

class Loading extends StatelessWidget {
  const Loading({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
