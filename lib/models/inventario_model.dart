// To parse this JSON data, do
//
//     final inventarios = inventariosFromJson(jsonString);

import 'dart:convert';

Inventarios inventariosFromJson(String str) =>
    Inventarios.fromJson(json.decode(str));

String inventariosToJson(Inventarios data) => json.encode(data.toJson());

class Inventarios {
  Inventarios({
    this.ok,
    this.inventario,
  });

  bool ok;
  List<Inventario> inventario;

  factory Inventarios.fromJson(Map<String, dynamic> json) => Inventarios(
        ok: json["ok"],
        inventario: List<Inventario>.from(
            json["inventario"].map((x) => Inventario.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "ok": ok,
        "inventario": List<dynamic>.from(inventario.map((x) => x.toJson())),
      };
}

class Inventario {
  Inventario({
    this.productoId,
    this.codigo,
    this.producto,
    this.cantidad,
  });

  int productoId;
  String codigo;
  String producto;
  int cantidad;

  factory Inventario.fromJson(Map<String, dynamic> json) => Inventario(
        productoId: json["ProductoId"],
        codigo: json["Codigo"],
        producto: json["Producto"],
        cantidad: json["Cantidad"],
      );

  Map<String, dynamic> toJson() => {
        "ProductoId": productoId,
        "Codigo": codigo,
        "Producto": producto,
        "Cantidad": cantidad,
      };
}
