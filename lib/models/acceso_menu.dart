import 'package:flutter/material.dart';

class AccesoMenu {
  final String ruta;
  final IconData icono;
  final String etiqueta;
  final String descripcion;
  final Widget pantalla;

  AccesoMenu({
    required this.ruta,
    required this.icono,
    required this.etiqueta,
    required this.descripcion,
    required this.pantalla,
  });
}