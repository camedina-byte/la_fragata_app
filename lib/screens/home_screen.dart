import 'package:flutter/material.dart';
import 'package:la_fragata_app/data/datos_fragata.dart';
import 'package:la_fragata_app/routes/rutas_fragata.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';

class PantallaInicio extends StatelessWidget {
  const PantallaInicio({super.key});

  @override
  Widget build(BuildContext context) {
    final accesos = RutasFragata.listaAccesos;

    return Scaffold(
      appBar: AppBar(
        title: const Text('La Fragata App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Encabezado
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: TemaFragata.azulMarino,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(32),
                bottomRight: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bienvenido,',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  DatosFragata.administrador,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  DatosFragata.nombreCiudadela,
                  style: TextStyle(
                    color: TemaFragata.dorado,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(height: 16),
                // Chip del mes actual
                Chip(
                  avatar: const Icon(
                    Icons.calendar_month,
                    color: TemaFragata.azulMarino,
                    size: 16,
                  ),
                  label: Text(
                    DatosFragata.mesActual,
                    style: const TextStyle(
                      color: TemaFragata.azulMarino,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  backgroundColor: TemaFragata.dorado,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Título del menú
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Accesos rápidos',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: TemaFragata.azulMarino,
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),

          // Menú de accesos
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: accesos.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, indice) {
                final acceso = accesos[indice];
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: CircleAvatar(
                      backgroundColor: TemaFragata.azulMarino,
                      child: Icon(
                        acceso.icono,
                        color: TemaFragata.dorado,
                      ),
                    ),
                    title: Text(
                      acceso.etiqueta,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: TemaFragata.azulMarino,
                      ),
                    ),
                    subtitle: Text(
                      acceso.descripcion,
                      style: const TextStyle(fontSize: 12),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                      color: TemaFragata.azulMedio,
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, acceso.ruta);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}