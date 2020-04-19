// To parse this JSON data, do
//
//     final kullanicilar = kullanicilarFromJson(jsonString);

import 'dart:convert';

Kullanicilar kullanicilarFromJson(String str) => Kullanicilar.fromJson(json.decode(str));

String kullanicilarToJson(Kullanicilar data) => json.encode(data.toJson());

class Kullanicilar {
    int id;
    String kullaniciAdi;
    String sifre;

    Kullanicilar({
        this.id,
        this.kullaniciAdi,
        this.sifre,
    });

    factory Kullanicilar.fromJson(Map<String, dynamic> json) => Kullanicilar(
        id: json["id"],
        kullaniciAdi: json["kullaniciAdi"],
        sifre: json["sifre"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "kullaniciAdi": kullaniciAdi,
        "sifre": sifre,
    };
}
