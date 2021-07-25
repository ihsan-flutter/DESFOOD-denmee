import 'package:desfood/Servisler/Auth_Service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class AnasayfaPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final loginprovider=Provider.of<AuthService>(context);
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: ()async=>await loginprovider.cikismethod(),
            ),
          ),
        ],
      ),
      
    );
  }
}