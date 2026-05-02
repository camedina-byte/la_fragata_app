import 'package:flutter/material.dart';
import 'package:la_fragata_app/routes/rutas_fragata.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';

void main() {
  runApp(const LaFragataApp());
}

class LaFragataApp extends StatelessWidget {
  const LaFragataApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'La Fragata App',
      debugShowCheckedModeBanner: false,
      theme: TemaFragata.temaClaro,
      initialRoute: RutasFragata.rutaInicial,
      routes: RutasFragata.obtenerRutas(),
    );
  }
}