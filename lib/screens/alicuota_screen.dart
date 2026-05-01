import 'package:flutter/material.dart';
import 'package:la_fragata_app/data/datos_fragata.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';

class AlicuotaScreen extends StatelessWidget {
  const AlicuotaScreen({super.key});

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

  IconData _iconoEstado(String estado) {
    switch (estado) {
      case 'Pagado':
        return Icons.check_circle;
      case 'Vencido':
        return Icons.cancel;
      default:
        return Icons.schedule;
    }
  }

  @override
  Widget build(BuildContext context) {
    final pagos = DatosFragata.historialPagos;
    final pagados = pagos.where((p) => p['estado'] == 'Pagado').length;
    final progreso = pagados / pagos.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Alícuota 2026'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tarjeta resumen
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DatosFragata.administrador,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: TemaFragata.azulMarino,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      DatosFragata.nombreCiudadela,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const Divider(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Valor mensual:'),
                        Text(
                          '\$${DatosFragata.montoAlicuota.toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: TemaFragata.azulMedio,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Meses pagados: $pagados / ${pagos.length}'),
                        Text(
                          '\$${(pagados * DatosFragata.montoAlicuota).toStringAsFixed(2)} pagado',
                          style: const TextStyle(color: TemaFragata.verdePagado),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progreso,
                        minHeight: 12,
                        backgroundColor: Colors.grey.shade200,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          TemaFragata.verdePagado,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Historial de pagos',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: TemaFragata.azulMarino,
              ),
            ),
            const SizedBox(height: 8),

            // Lista de meses
            Expanded(
              child: ListView.separated(
                itemCount: pagos.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, indice) {
                  final pago = pagos[indice];
                  final estado = pago['estado']!;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: _colorEstado(estado).withOpacity(0.15),
                      child: Icon(
                        _iconoEstado(estado),
                        color: _colorEstado(estado),
                      ),
                    ),
                    title: Text(pago['mes']!),
                    trailing: Chip(
                      label: Text(
                        estado,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                      backgroundColor: _colorEstado(estado),
                      padding: EdgeInsets.zero,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}