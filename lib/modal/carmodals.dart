/// YApi QuickType插件生成，具体参考文档:https://plugins.jetbrains.com/plugin/18847-yapi-quicktype/documentation

import 'dart:convert';

Carmodals carmodalsFromJson(String str) => Carmodals.fromJson(json.decode(str));

String carmodalsToJson(Carmodals data) => json.encode(data.toJson());

class Carmodals {
    Carmodals({
        required this.data,
        required this.status,
    });

    List<Datum> data;
    String status;

    factory Carmodals.fromJson(Map<dynamic, dynamic> json) => Carmodals(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        status: json["status"],
    );

    Map<dynamic, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "status": status,
    };
}

class Datum {
    Datum({
        required this.amount,
        required this.updatedAt,
        required this.imgPath,
        required this.prefix,
        required this.createdAt,
        required this.id,
        this.placeholder,
        required this.title,
    });

    double amount;
    DateTime updatedAt;
    String imgPath;
    String prefix;
    DateTime createdAt;
    int id;
    String? placeholder;
    String title;

    factory Datum.fromJson(Map<dynamic, dynamic> json) => Datum(
        amount: json["amount"]?.toDouble(),
        updatedAt: DateTime.parse(json["updated_at"]),
        imgPath: json["img_path"],
        prefix: json["prefix"],
        createdAt: DateTime.parse(json["created_at"]),
        id: json["id"],
        placeholder: json["placeholder"],
        title: json["title"],
    );

    Map<dynamic, dynamic> toJson() => {
        "amount": amount,
        "updated_at": updatedAt.toIso8601String(),
        "img_path": imgPath,
        "prefix": prefix,
        "created_at": createdAt.toIso8601String(),
        "id": id,
        "placeholder": placeholder,
        "title": title,
    };
}
