import 'dart:convert';
import 'package:flutter/material.dart';
import 'models/kullanicilar.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String url = "http://192.168.1.20:3000/api/login";
  Future<List<Kullanicilar>> _getir() async {
    var response = await http.get(url);
    if (response.statusCode == 200) {
      return (json.decode(response.body) as List)
          .map((tekGonderiMap) => Kullanicilar.fromJson(tekGonderiMap))
          .toList();
    } else {
      throw Exception("Bağlanamadık ${response.statusCode}");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text("Node js Android Bağlantısı"),
        ),
        body: FutureBuilder(
          future: _getir(),
          builder: (BuildContext context,
              AsyncSnapshot<List<Kullanicilar>> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                        "Kullanici Adi :  ${snapshot.data[index].kullaniciAdi}"),
                    subtitle: Text("Şifre : ${snapshot.data[index].sifre}"),
                    leading: CircleAvatar(
                      child: Text(snapshot.data[index].id.toString()),
                    ),
                  );
                },
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
