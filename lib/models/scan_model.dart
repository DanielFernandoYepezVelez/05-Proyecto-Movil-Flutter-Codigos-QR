// To parse this JSON data, do
// final scanModel = scanModelFromJson(jsonString);

import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

ScanModel scanModelFromJson(String str) => ScanModel.fromJson(json.decode(str));
String scanModelToJson(ScanModel data) => json.encode(data.toJson());

class ScanModel {
  int id;
  String tipo;
  String valor;

  ScanModel({ this.id, this.tipo, @required this.valor }) {
    if (this.valor.contains('http')) {
      this.tipo = 'http';
    } else {
      this.tipo = 'geo';
    }
  }

  /* Latitud Y Longitud Google Maps */
  LatLng getLatLng() {
    final latLng = valor.substring(4).split(',');
    final lat = double.parse(latLng[0]);
    final lng = double.parse(latLng[1]);

    return LatLng(lat, lng);
  }

  /* Retorna Una Nueva Instancia De La Clase ScanModel Con Sus Respectivos
   * Argumentos Y Valores De Los Mismos */
  /* Se Utiliza Para Obtener Un Registro Por ID De La Base De Datos */
  factory ScanModel.fromJson(Map<String, dynamic> json) => ScanModel(
        id: json["id"],
        tipo: json["tipo"],
        valor: json["valor"],
      );

  /* Aqui Estoy Convirtiendo Los Valores De La Clase A Jsons */
  /* Se Utiliza Para Insertar Registros En La Base De Datos */
  Map<String, dynamic> toJson() => {
        "id": id,
        "tipo": tipo,
        "valor": valor,
      };
}
