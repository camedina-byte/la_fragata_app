import 'dart:async';
import 'package:flutter/material.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';

class PortonScreen extends StatefulWidget {
  const PortonScreen({super.key});

  @override
  State<PortonScreen> createState() => _PortonScreenState();
}

class _PortonScreenState extends State<PortonScreen> {
  bool _portonAbierto = false;
  bool _procesando    = false;
  int  _segundos      = 30;
  Timer? _temporizador;

  void _iniciarContador() {
    _segundos = 30;
    _temporizador = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _segundos--);

      if (_segundos <= 0) {
        timer.cancel();
        _cerrarAutomatico();
      }
    });
  }

  Future<void> _cerrarAutomatico() async {
    setState(() => _procesando = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() {
      _portonAbierto = false;
      _procesando    = false;
      _segundos      = 30;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔒 Portón cerrado automáticamente'),
        backgroundColor: TemaFragata.azulMarino,
        duration: Duration(seconds: 2),
      ),
    );
  }

  Future<void> _accionarPorton() async {
    _temporizador?.cancel();
    setState(() => _procesando = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;

    setState(() {
      _portonAbierto = !_portonAbierto;
      _procesando    = false;
    });

				  
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _portonAbierto
              ? '✅ Portón abierto — se cerrará en 30 segundos'
              : '🔒 Portón cerrado correctamente',
			
						  
																				
											   
        ),
        backgroundColor: _portonAbierto
            ? TemaFragata.verdePagado
            : TemaFragata.azulMarino,
        duration: const Duration(seconds: 2),
      ),
    );

    if (_portonAbierto) _iniciarContador();
  }

  @override
  void dispose() {
    _temporizador?.cancel();
    super.dispose();
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
              // Ícono principal
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

              const SizedBox(height: 16),

              // Contador regresivo — solo visible cuando está abierto
              if (_portonAbierto && !_procesando)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: TemaFragata.rojoPendiente.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: TemaFragata.rojoPendiente.withOpacity(0.4),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.timer,
                        color: TemaFragata.rojoPendiente,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Cierre automático en $_segundos segundos',
                        style: const TextStyle(
                          color: TemaFragata.rojoPendiente,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 32),

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