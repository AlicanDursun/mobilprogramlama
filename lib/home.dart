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
            child: OutlineButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Select()));
                },
                icon: Icon(
                  Icons.adb,
                  color: Colors.green,
                ),
                label: Text("Kullanıcıları göster")),
          ),
          Center(
            child: OutlineButton.icon(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Insert()));
                },
                icon: Icon(
                  Icons.group_add,
                  color: Colors.green,
                ),
                label: Text("Kullanıcıları göster")),
          ),
        ],
      ),
    );
  }
}
