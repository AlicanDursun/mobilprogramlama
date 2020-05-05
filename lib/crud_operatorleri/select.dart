import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobilprogramlama/crud_operatorleri/update.dart';
import 'package:mobilprogramlama/models/kullanicilar.dart';
import 'package:http/http.dart' as http;

class Select extends StatefulWidget {
  Kullanicilar kullanicilar;
  Select({this.kullanicilar});
  @override
  _SelectState createState() => _SelectState();
}

class _SelectState extends State<Select> {
  Future<List<Kullanicilar>> _getir() async {
    String url = "http://192.168.1.20:3000/api/login";
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((veri) => Kullanicilar.fromJson(veri))
          .toList();
    } else {
      throw Exception("Bağlanamadık ${response.statusCode}");
    }
  }

  Future<bool> kullaniciSil(id) async {
    String url = "http://192.168.1.20:3000/api/user/";
    final response = await http.delete(
      "$url$id",
      headers: {"content-type": "application/json"},
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
        title: Text(
          "Kullanıcıları Görüntüleme Ekranı",
          style: TextStyle(fontSize: 15),
        ),
      ),
      body: SafeArea(
        child: FutureBuilder(
          future: _getir(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Kullanicilar>> snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("HATA : ${snapshot.error.toString()}"),
              );
            } else if (snapshot.connectionState == ConnectionState.done) {
              List<Kullanicilar> kullanicilar = snapshot.data;
              return _benimListView(kullanicilar);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Widget _benimListView(List<Kullanicilar> kullanicilar) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: ListView.builder(
        itemBuilder: (context, index) {
          Kullanicilar kullanici = kullanicilar[index];
          return Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CircleAvatar(
                      child: Text(kullanici.id.toString()),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "Kullanici Adi :  ${kullanici.kullaniciAdi}",
                    ),
                    Text("Şifre : ${kullanici.sifre}"),
                    SizedBox(height: 10.0,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        OutlineButton.icon(
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Dikkat",style: TextStyle(color:Colors.red),),
                                      content: Text(
                                          "Silmek istediğinize emin misiniz ${kullanici.kullaniciAdi}"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text("Evet"),
                                          onPressed: () {
                                            Navigator.pop(context);
                                            kullaniciSil(kullanici.id);
                                            setState(() {});
                                          },
                                        ),
                                        FlatButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: Text("Hayır"))
                                      ],
                                    );
                                  });
                            },
                            icon: Icon(
                              Icons.group_add,
                              color: Colors.green,
                            ),
                            label: Text("Sil")),
                        SizedBox(
                          width: 10.0,
                        ),
                        OutlineButton.icon(
                          label: Text("Düzenle"),
                          icon: Icon(
                            Icons.hd,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Update(
                                          kullanici: kullanici,
                                        )));
                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        },
        itemCount: kullanicilar.length,
      ),
    );
  }
}
