import 'package:flutter/material.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';
import 'package:la_fragata_app/data/datos_fragata.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _controladorUsuario = TextEditingController();
  final _controladorPassword = TextEditingController();
  bool _passwordOculto = true;
  String? _errorMensaje;

  void _iniciarSesion() {
    final usuario  = _controladorUsuario.text.trim();
    final password = _controladorPassword.text.trim();

    if (usuario == 'demo' && password == 'demo') {
      Navigator.pushReplacementNamed(context, 'inicio');
    } else {
      setState(() {
        _errorMensaje = 'Usuario o contraseña incorrectos';
      });
    }
  }

  @override
  void dispose() {
    _controladorUsuario.dispose();
    _controladorPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TemaFragata.azulMarino,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo / ícono
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: TemaFragata.dorado,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.location_city,
                  color: TemaFragata.azulMarino,
                  size: 52,
                ),
              ),

              const SizedBox(height: 24),

              // Nombre de la app
              const Text(
                'La Fragata App',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 4),

              Text(
                DatosFragata.nombreCiudadela,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 14,
                ),
              ),

              const SizedBox(height: 40),

              // Card del formulario
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Iniciar Sesión',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: TemaFragata.azulMarino,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Campo usuario
                      TextField(
                        controller: _controladorUsuario,
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          prefixIcon: const Icon(Icons.person),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),

                      const SizedBox(height: 16),

                      // Campo password
                      TextField(
                        controller: _controladorPassword,
                        obscureText: _passwordOculto,
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: IconButton(
                            onPressed: () => setState(
                                () => _passwordOculto = !_passwordOculto),
                            icon: Icon(
                              _passwordOculto
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onSubmitted: (_) => _iniciarSesion(),
                      ),

                      // Error
                      if (_errorMensaje != null) ...[
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            const Icon(Icons.error_outline,
                                color: TemaFragata.rojoPendiente, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              _errorMensaje!,
                              style: const TextStyle(
                                color: TemaFragata.rojoPendiente,
                                fontSize: 13,
                              ),
                            ),
                          ],
                        ),
                      ],

                      const SizedBox(height: 24),

                      // Botón ingresar
                      SizedBox(
                        width: double.infinity,
                        height: 50,
                        child: ElevatedButton.icon(
                          onPressed: _iniciarSesion,
                          icon: const Icon(Icons.login),
                          label: const Text(
                            'Ingresar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),

                      const SizedBox(height: 12),

                      // Credenciales de demo
                      Center(
                        child: Text(
                          'Usuario: demo  |  Contraseña: demo',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'v1.0.0 — ${DatosFragata.administrador}',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.4),
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}