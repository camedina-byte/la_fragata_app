import 'package:flutter/material.dart';
import 'package:la_fragata_app/data/datos_fragata.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';

class FamiliasScreen extends StatelessWidget {
  const FamiliasScreen({super.key});

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'Pagado':
        return TemaFragata.verdePagado;
      case 'Vencido':
        return TemaFragata.rojoPendiente;
      default:
        return TemaFragata.naranjaVencido;
    }
  }

  @override
  Widget build(BuildContext context) {
    final manzana2262 = DatosFragata.familias
        .where((f) => f['manzana'] == '2262')
        .toList();
    final manzana2261 = DatosFragata.familias
        .where((f) => f['manzana'] == '2261')
        .toList();

    final totalPagadas = DatosFragata.familias
        .where((f) => f['estado'] == 'Pagado')
        .length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Familias Residentes'),
      ),
      body: Column(
        children: [
          // Resumen general
          Container(
            width: double.infinity,
            margin: const EdgeInsets.all(16),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: TemaFragata.azulMarino,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _tarjetaContador(
                  'Total',
                  '${DatosFragata.totalFamilias}',
                  Icons.home,
                ),
                _tarjetaContador(
                  'Al día',
                  '$totalPagadas',
                  Icons.check_circle,
                ),
                _tarjetaContador(
                  'Pendientes',
                  '${DatosFragata.totalFamilias - totalPagadas}',
                  Icons.schedule,
                ),
              ],
            ),
          ),

          // Lista por manzana
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _encabezadoManzana('Manzana 2262'),
                ...manzana2262.map(
                  (familia) => _tarjetaFamilia(familia),
                ),
                const SizedBox(height: 16),
                _encabezadoManzana('Manzana 2261'),
                ...manzana2261.map(
                  (familia) => _tarjetaFamilia(familia),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _encabezadoManzana(String titulo) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        titulo,
        style: const TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.bold,
          color: TemaFragata.azulMedio,
        ),
      ),
    );
  }

  Widget _tarjetaFamilia(Map<String, String> familia) {
    final estado = familia['estado']!;
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: TemaFragata.azulMarino,
          child: Text(
            familia['id']!,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          'Familia ${familia['apellido']}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text('Manzana ${familia['manzana']}'),
        trailing: Chip(
          label: Text(
            estado,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
            ),
          ),
          backgroundColor: _colorEstado(estado),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }

  Widget _tarjetaContador(String etiqueta, String valor, IconData icono) {
    return Column(
      children: [
        Icon(icono, color: TemaFragata.dorado, size: 28),
        const SizedBox(height: 4),
        Text(
          valor,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          etiqueta,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}