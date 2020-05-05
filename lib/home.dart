import 'package:flutter/material.dart';
import 'package:mobilprogramlama/crud_operatorleri/Insert.dart';
import 'package:mobilprogramlama/crud_operatorleri/select.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Crud İşlemleri"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Select()));
              },
              child: Text("Kullanıcıları görüntüle"),
            ),
          ),
          Center(
            child: RaisedButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => Insert()));
              },
              child: Text("Yeni Kullanıcı Ekleme İşlemi"),
            ),
          ),
        ],
      ),
    );
  }
}
