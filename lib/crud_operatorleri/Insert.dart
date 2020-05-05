import 'package:flutter/material.dart';
import 'package:mobilprogramlama/models/kullanicilar.dart';
import 'package:http/http.dart' as http;

import 'select.dart';

final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class Insert extends StatefulWidget {
  @override
  _InsertState createState() => _InsertState();
}

class _InsertState extends State<Insert> {
  final _kullaniciKontrol = TextEditingController();
  final _sifreKontrol = TextEditingController();
  final formKey = GlobalKey<FormState>();
  String url = "http://192.168.1.20:3000/api/user";
  Future<bool> yeniKullanici(Kullanicilar data) async {
    final response = await http.post(
      url,
      headers: {"content-type": "application/json"},
      body: kullanicilarToJson(data),
    );
    if (response.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("İNSERT İŞLEMİ"),
      ),
      body: Form(
        child: Column(
          children: <Widget>[
            kullaniciAlani(),
            sifreAlani(),
            Padding(
              padding: EdgeInsets.only(top: 40),
              child: MaterialButton(
                onPressed: () {
                  String adi = _kullaniciKontrol.text.toString();
                  String sifre = _sifreKontrol.text.toString();
                  Kullanicilar kullanici =
                      Kullanicilar(kullaniciAdi: adi, sifre: sifre);
                  yeniKullanici(kullanici);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Select()));
                },
                child: Text(
                  'EKLE',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                hoverColor: Color(0xFF333333),
                highlightColor: Color(0xFF333333),
                color: Color(0xFF57B846),
                elevation: 0,
                minWidth: 350,
                height: 50,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget kullaniciAlani() {
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
      child: TextFormField(
        // validator: validateKullaniciAdi,
        controller: _kullaniciKontrol,
        cursorColor: Color(0xFF333333),
        style: TextStyle(
          color: Colors.grey,
        ),
        decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFF57B846),
              ),
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.grey,
              ),
            ),
            labelText: 'Kullanıcı Adı',
            labelStyle: TextStyle(fontSize: 15, color: Colors.grey)),
      ),
    );
  }

  Widget sifreAlani() {
    return TextFormField(
      //validator: validateSifre,
      controller: _sifreKontrol,
      cursorColor: Color(0xFF333333),
      obscureText: true,
      style: TextStyle(
        color: Colors.grey,
      ),
      decoration: InputDecoration(
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0xFF57B846),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.grey,
            ),
          ),
          labelText: 'Şifre',
          labelStyle: TextStyle(fontSize: 15, color: Colors.grey)),
    );
  }
}
