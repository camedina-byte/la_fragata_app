import 'package:flutter/material.dart';
import 'package:la_fragata_app/models/acceso_menu.dart';
import 'package:la_fragata_app/screens/alicuota_screen.dart';
import 'package:la_fragata_app/screens/familias_screen.dart';
import 'package:la_fragata_app/screens/home_screen.dart';
import 'package:la_fragata_app/screens/porton_screen.dart';
import 'package:la_fragata_app/screens/espacios_screen.dart';
import 'package:la_fragata_app/screens/login_screen.dart';

class RutasFragata {
  static const String rutaInicial = 'inicio';

  static final List<AccesoMenu> listaAccesos = [
    AccesoMenu(
      ruta: 'porton',
      icono: Icons.sensor_door,
      etiqueta: 'Control de Portón',
      descripcion: 'Abrir o cerrar el portón de la cuadra',
      pantalla: const PortonScreen(),
    ),
    AccesoMenu(
      ruta: 'alicuota',
      icono: Icons.receipt_long,
      etiqueta: 'Mi Alícuota',
      descripcion: 'Estado de pagos mensuales del año',
      pantalla: const AlicuotaScreen(),
    ),
    AccesoMenu(
      ruta: 'familias',
      icono: Icons.people,
      etiqueta: 'Familias Residentes',
      descripcion: 'Lista de las 24 familias y su estado',
      pantalla: const FamiliasScreen(),
    ),
    AccesoMenu(
      ruta: 'espacios',
      icono: Icons.local_parking,
      etiqueta: 'Espacios de Parqueo',
      descripcion: 'Vehículos registrados por domicilio',
      pantalla: const EspaciosScreen(),
    ),
  ];

  static Map<String, Widget Function(BuildContext)> obtenerRutas() {
    Map<String, Widget Function(BuildContext)> rutas = {
      rutaInicial: (context) => const PantallaInicio(),
    };

    for (final acceso in listaAccesos) {
      rutas[acceso.ruta] = (context) => acceso.pantalla;
    }

    rutas['login'] = (context) => const LoginScreen();
    
    return rutas;
  }
}