import 'package:flutter/material.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';

class PortonScreen extends StatefulWidget {
  const PortonScreen({super.key});

  @override
  State<PortonScreen> createState() => _PortonScreenState();
}

class _PortonScreenState extends State<PortonScreen> {
  bool _portonAbierto = false;
  bool _procesando = false;

  Future<void> _accionarPorton() async {
    setState(() => _procesando = true);

    // Simula tiempo de respuesta del motor
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _portonAbierto = !_portonAbierto;
      _procesando = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _portonAbierto
                ? '✅ Portón abierto correctamente'
                : '🔒 Portón cerrado correctamente',
          ),
          backgroundColor:
              _portonAbierto ? TemaFragata.verdePagado : TemaFragata.azulMarino,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Control de Portón'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Ícono principal del portón
              AnimatedContainer(
                duration: const Duration(milliseconds: 500),
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  color: _portonAbierto
                      ? TemaFragata.verdePagado.withOpacity(0.1)
                      : TemaFragata.rojoPendiente.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: _portonAbierto
                        ? TemaFragata.verdePagado
                        : TemaFragata.rojoPendiente,
                    width: 3,
                  ),
                ),
                child: Icon(
                  _portonAbierto ? Icons.lock_open : Icons.lock,
                  size: 80,
                  color: _portonAbierto
                      ? TemaFragata.verdePagado
                      : TemaFragata.rojoPendiente,
                ),
              ),

              const SizedBox(height: 32),

              // Estado actual
              Text(
                _portonAbierto ? 'Portón Abierto' : 'Portón Cerrado',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _portonAbierto
                      ? TemaFragata.verdePagado
                      : TemaFragata.rojoPendiente,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Ciudadela La Fragata',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 48),

              // Botón de acción
              _procesando
                  ? Column(
                      children: [
                        const CircularProgressIndicator(
                          color: TemaFragata.azulMarino,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          _portonAbierto ? 'Cerrando...' : 'Abriendo...',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    )
                  : SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton.icon(
                        onPressed: _accionarPorton,
                        icon: Icon(
                          _portonAbierto ? Icons.lock : Icons.lock_open,
                        ),
                        label: Text(
                          _portonAbierto ? 'Cerrar Portón' : 'Abrir Portón',
                          style: const TextStyle(fontSize: 18),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: _portonAbierto
                              ? TemaFragata.rojoPendiente
                              : TemaFragata.verdePagado,
                        ),
                      ),
                    ),

              const SizedBox(height: 24),

              // Aviso informativo
              if (_portonAbierto)
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: TemaFragata.dorado.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: TemaFragata.dorado.withOpacity(0.4),
                  ),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.info_outline, color: TemaFragata.dorado),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'El portón se cerrará automáticamente después de 30 segundos.',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}