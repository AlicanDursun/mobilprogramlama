import 'package:flutter/material.dart';
import 'package:mobilprogramlama/crud_operatorleri/select.dart';
import 'package:mobilprogramlama/models/kullanicilar.dart';
import 'package:http/http.dart' as http;

class Update extends StatefulWidget {
  Kullanicilar kullanici;
  Update({this.kullanici});
  @override
  _UpdateState createState() => _UpdateState();
}

class _UpdateState extends State<Update> {
  TextEditingController _kullaniciKontrol = TextEditingController();
  TextEditingController _sifreKontrol = TextEditingController();
  int id;

  @override
  void initState() {
    super.initState();
    _kullaniciKontrol.text = widget.kullanici.kullaniciAdi;
    _sifreKontrol.text = widget.kullanici.sifre;
  }

  final formKey = GlobalKey<FormState>();
  String url = "http://192.168.1.20:3000/api/user/";
  Future<bool> updateProfile(Kullanicilar data) async {
    final response = await http.put(
      "$url${widget.kullanici.id}",
      headers: {"content-type": "application/json"},
      body: kullanicilarToJson(data),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kullanıcı Güncelle"),
      ),
      body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            kullaniciAlani(),
            sifreAlani(),
            Padding(
              padding: EdgeInsets.only(left: 50.0, right: 50.0),
              child: MaterialButton(
                onPressed: () {
                  Kullanicilar kullanici = Kullanicilar(
                      kullaniciAdi: _kullaniciKontrol.text,
                      sifre: _sifreKontrol.text);
                  updateProfile(kullanici);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => Select()));
                },
                child: Text(
                  'Güncelle',
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
      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
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
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
          child: TextFormField(
        //validator: validateSifre,
        controller: _sifreKontrol,
        cursorColor: Color(0xFF333333),
        obscureText: false,
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
      ),
    );
  }
}
