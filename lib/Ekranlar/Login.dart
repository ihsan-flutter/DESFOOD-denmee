// @dart=2.9
import 'package:desfood/Ekranlar/KayitOl.dart';
import 'package:desfood/Servisler/Auth_Service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Login extends StatefulWidget {
  final Function toggleScreen;

  const Login({Key key, this.toggleScreen}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _email = TextEditingController();
  TextEditingController _sifre = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  @override
  void initState() {
    _email = TextEditingController();
    _sifre = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _sifre.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loginprovider = Provider.of<AuthService>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 60),
                  Text(
                    "HOŞ GELDİNİZ",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  Text(
                    "DEVAM ETMEK İÇİN OTURUM AÇIN",
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _email,
                    validator: (val) {
                      if (val.isEmpty) {
                        return "Email Boş Geçilemez";
                      }

                      return val.contains("@")
                          ? null
                          : "Lütfen Geçerli Bir Email Giriniz";
                    },
                    decoration: InputDecoration(
                      hintText: "Email",
                      labelText: "Email",
                      prefixIcon: Icon(Icons.mail),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  TextFormField(
                    validator: (val) => val.length < 6
                        ? "Şifreniz En Az 6 Karakter Olmalıdır "
                        : null,
                    controller: _sifre,
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Şifre",
                      labelText: "Şifre",
                      prefixIcon: Icon(Icons.vpn_key_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  MaterialButton(
                    
                    onPressed: () async {
                      if (_formkey.currentState.validate()) {
                        print("Email: ${_email.text}");
                        print("Şifre: ${_sifre.text}");
                        await loginprovider.girismethod(
                            _email.text.trim(), _sifre.text.trim());
                      }
                    },
                    height: 50,
                    minWidth: double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                            "GİRİŞ YAP",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Hesabınız Yokmu?",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => KayitOl()));
                        },
                        child: Text(
                          "Kayıt Ol",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
