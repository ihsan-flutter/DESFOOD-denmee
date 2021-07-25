// @dart=2.9
import 'package:desfood/Ekranlar/Login.dart';
import 'package:desfood/Servisler/Auth_Service/Auth_Service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class KayitOl extends StatefulWidget {
  final Function toggleScreen;

  const KayitOl({Key key, this.toggleScreen}) : super(key: key);

  @override
  _KayitOlState createState() => _KayitOlState();
}

class _KayitOlState extends State<KayitOl> {
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
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Theme.of(context).primaryColor,
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (_) => Login(),
                          ),
                          (Route route) => false);
                    },
                  ),
                  SizedBox(height: 60),
                  Text(
                    "HESAP OLUŞTURUN",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10),
                  SizedBox(height: 30),
                  TextFormField(
                    controller: _email,
                    validator: (val) => val.isNotEmpty
                        ? null
                        : "LÜTFEN MAİL ADRESİNİZİ GİRİNİZ",
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
                        await loginprovider.kayitolmethod(
                            _email.text.trim(), _sifre.text.trim());
                      }
                    },
                    height: 50,
                    minWidth: loginprovider.isloading ? null : double.infinity,
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: loginprovider.isloading
                        ? CircularProgressIndicator(
                            valueColor:
                                new AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                        : Text(
                            "KAYIT OL",
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
                        "Hesabınız Var Mı?",
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold,color: Colors.grey),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      TextButton(
                        onPressed: () => widget.toggleScreen(),
                        child: Text(
                          "Giriş Yap",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (loginprovider.errorMessage != null)
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      color: Colors.amberAccent,
                      child: ListTile(
                        title: Text(loginprovider.errorMessage),
                        leading: Icon(Icons.error),
                        trailing: IconButton(
                          icon: Icon(Icons.close),
                          onPressed: () => loginprovider.setMessage(null),
                        ),
                      ),
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
