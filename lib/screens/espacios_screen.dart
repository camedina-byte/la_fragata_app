import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:la_fragata_app/data/datos_fragata.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';

class EspaciosScreen extends StatefulWidget {
  const EspaciosScreen({super.key});

  @override
  State<EspaciosScreen> createState() => _EspaciosScreenState();
}

class _EspaciosScreenState extends State<EspaciosScreen> {
  static const int espaciosPorDomicilio = 2;

  // Copia local de los domicilios para poder modificarlos
  late List<Map<String, dynamic>> _domicilios;

  @override
  void initState() {
    super.initState();
    _domicilios = DatosFragata.domicilios.map((d) {
      return {
        ...d,
        'vehiculos': List<Map<String, dynamic>>.from(
          (d['vehiculos'] as List).map((v) => Map<String, dynamic>.from(v)),
        ),
      };
    }).toList();
  }

  int _espaciosOcupados(List<dynamic> vehiculos) {
    int autos = vehiculos.where((v) => v['tipo'] == 'auto').length;
    int motos = vehiculos.where((v) => v['tipo'] == 'moto').length;
    return autos + (motos / 3).ceil();
  }

  String _estadoEspacio(int ocupados) {
    if (ocupados == 0) return 'Libre';
    if (ocupados <= espaciosPorDomicilio) return 'Ocupado';
    return 'Excedido';
  }

  Color _colorEstado(String estado) {
    switch (estado) {
      case 'Libre':
        return TemaFragata.verdePagado;
      case 'Ocupado':
        return TemaFragata.azulMedio;
      default:
        return TemaFragata.rojoPendiente;
    }
  }

  // Validar formato GYE-1234
  bool _validarPlaca(String placa) {
    final RegExp formatoPlaca = RegExp(r'^[A-Z]{3}-\d{4}$');
    return formatoPlaca.hasMatch(placa.toUpperCase());
  }

  void _agregarVehiculo(BuildContext context, int indiceDomicilio) {
    final controladorPlaca = TextEditingController();
    String tipoSeleccionado = 'auto';
    String titularSeleccionado = 'Propietario';
    String? errorPlaca;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setStateDialog) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.add_circle, color: TemaFragata.azulMarino),
              SizedBox(width: 8),
              Text('Registrar Vehículo'),
            ],
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Campo placa
              TextField(
                controller: controladorPlaca,
                textCapitalization: TextCapitalization.characters,
                inputFormatters: [
                  TextInputFormatter.withFunction((oldValue, newValue) {
                    return newValue.copyWith(
                      text: newValue.text.toUpperCase(),
                    );
                  }),
                ],
                decoration: InputDecoration(
                  labelText: 'Placa',
                  hintText: 'GYE-1234',
                  errorText: errorPlaca,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  prefixIcon: const Icon(Icons.badge),
                ),
              ),

              const SizedBox(height: 16),

              // Tipo de vehículo
              const Text(
                'Tipo de vehículo:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: TemaFragata.azulMarino,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          setStateDialog(() => tipoSeleccionado = 'auto'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: tipoSeleccionado == 'auto'
                              ? TemaFragata.azulMarino
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: tipoSeleccionado == 'auto'
                                ? TemaFragata.azulMarino
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.directions_car,
                              color: tipoSeleccionado == 'auto'
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Auto',
                              style: TextStyle(
                                color: tipoSeleccionado == 'auto'
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () =>
                          setStateDialog(() => tipoSeleccionado = 'moto'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: tipoSeleccionado == 'moto'
                              ? TemaFragata.azulMarino
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: tipoSeleccionado == 'moto'
                                ? TemaFragata.azulMarino
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.two_wheeler,
                              color: tipoSeleccionado == 'moto'
                                  ? Colors.white
                                  : Colors.grey,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Moto',
                              style: TextStyle(
                                color: tipoSeleccionado == 'moto'
                                    ? Colors.white
                                    : Colors.grey,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Titular
              const Text(
                'Titular:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: TemaFragata.azulMarino,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: ['Propietario', 'Arrendatario'].map((titular) {
                  final seleccionado = titularSeleccionado == titular;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setStateDialog(
                          () => titularSeleccionado = titular),
                      child: Container(
                        margin: EdgeInsets.only(
                          right: titular == 'Propietario' ? 8 : 0,
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: seleccionado
                              ? TemaFragata.azulMarino
                              : Colors.grey.shade100,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: seleccionado
                                ? TemaFragata.azulMarino
                                : Colors.grey.shade300,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            titular,
                            style: TextStyle(
                              color: seleccionado
                                  ? Colors.white
                                  : Colors.grey,
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                final placa = controladorPlaca.text.trim();
                if (!_validarPlaca(placa)) {
                  setStateDialog(() {
                    errorPlaca = 'Formato inválido. Ejemplo: GYE-1234';
                  });
                  return;
                }
                setState(() {
                  (_domicilios[indiceDomicilio]['vehiculos']
                          as List<Map<String, dynamic>>)
                      .add({
                    'placa': placa.toUpperCase(),
                    'tipo': tipoSeleccionado,
                    'titular': titularSeleccionado,
                  });
                });
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                        '✅ Vehículo ${placa.toUpperCase()} registrado'),
                    backgroundColor: TemaFragata.verdePagado,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  void _eliminarVehiculo(
      BuildContext context, int indiceDomicilio, int indiceVehiculo) {
    final vehiculos = _domicilios[indiceDomicilio]['vehiculos']
        as List<Map<String, dynamic>>;
    final placa = vehiculos[indiceVehiculo]['placa'];

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.delete_outline, color: TemaFragata.rojoPendiente),
            SizedBox(width: 8),
            Text('Eliminar Vehículo'),
          ],
        ),
        content: Text(
          '¿Deseas eliminar el vehículo con placa $placa?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: TemaFragata.rojoPendiente,
            ),
            onPressed: () {
              setState(() {
                vehiculos.removeAt(indiceVehiculo);
              });
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('🗑️ Vehículo $placa eliminado'),
                  backgroundColor: TemaFragata.rojoPendiente,
                  duration: const Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }

  void _mostrarDetalle(BuildContext context, int indiceDomicilio) {
    final domicilio = _domicilios[indiceDomicilio];
    final vehiculos = domicilio['vehiculos'] as List<Map<String, dynamic>>;
    final ocupados = _espaciosOcupados(vehiculos);
    final estado = _estadoEspacio(ocupados);
    final libres = espaciosPorDomicilio - ocupados;

    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (context, setStateDialog) {
          final vehiculosActuales = _domicilios[indiceDomicilio]['vehiculos']
              as List<Map<String, dynamic>>;
          final ocupadosActuales = _espaciosOcupados(vehiculosActuales);
          final estadoActual = _estadoEspacio(ocupadosActuales);
          final libresActuales = espaciosPorDomicilio - ocupadosActuales;

          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            title: Row(
              children: [
                const Icon(Icons.home, color: TemaFragata.azulMarino),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Familia ${domicilio['familia']}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
            content: SizedBox(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Resumen espacios
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: _colorEstado(estadoActual).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: _colorEstado(estadoActual).withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _contadorEspacio('Total', '$espaciosPorDomicilio',
                            Icons.garage, TemaFragata.azulMarino),
                        _contadorEspacio(
                            'Ocupados',
                            '${ocupadosActuales > espaciosPorDomicilio ? espaciosPorDomicilio : ocupadosActuales}',
                            Icons.directions_car,
                            TemaFragata.azulMedio),
                        _contadorEspacio(
                            'Libres',
                            '${libresActuales < 0 ? 0 : libresActuales}',
                            Icons.check_circle,
                            TemaFragata.verdePagado),
                      ],
                    ),
                  ),

                  if (estadoActual == 'Excedido') ...[
                    const SizedBox(height: 8),
                    const Row(
                      children: [
                        Icon(Icons.warning_amber,
                            color: TemaFragata.rojoPendiente, size: 16),
                        SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            'Cantidad de vehículos excede el límite',
                            style: TextStyle(
                              color: TemaFragata.rojoPendiente,
                              fontSize: 11,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 12),

                  // Encabezado vehículos
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Vehículos registrados:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: TemaFragata.azulMarino,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          _agregarVehiculo(context, indiceDomicilio);
                        },
                        icon: const Icon(
                          Icons.add_circle,
                          color: TemaFragata.verdePagado,
                        ),
                        tooltip: 'Agregar vehículo',
                      ),
                    ],
                  ),

                  // Lista de vehículos
                  if (vehiculosActuales.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 8),
                      child: Row(
                        children: [
                          Icon(Icons.info_outline,
                              color: Colors.grey, size: 16),
                          SizedBox(width: 8),
                          Text('Sin vehículos registrados',
                              style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    )
                  else
                    ...vehiculosActuales.asMap().entries.map((entry) {
                      final indice = entry.key;
                      final vehiculo = entry.value;
                      final esMoto = vehiculo['tipo'] == 'moto';
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          children: [
                            Icon(
                              esMoto
                                  ? Icons.two_wheeler
                                  : Icons.directions_car,
                              color: TemaFragata.azulMedio,
                              size: 20,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              vehiculo['placa'],
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Chip(
                              label: Text(
                                vehiculo['titular'],
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                              ),
                              backgroundColor:
                                  vehiculo['titular'] == 'Propietario'
                                      ? TemaFragata.azulMarino
                                      : TemaFragata.naranjaVencido,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                            ),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(ctx);
                                _eliminarVehiculo(
                                    context, indiceDomicilio, indice);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: TemaFragata.rojoPendiente,
                                size: 20,
                              ),
                              tooltip: 'Eliminar',
                              constraints: const BoxConstraints(),
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                      );
                    }),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Cerrar'),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _contadorEspacio(
      String etiqueta, String valor, IconData icono, Color color) {
    return Column(
      children: [
        Icon(icono, color: color, size: 22),
        const SizedBox(height: 2),
        Text(
          valor,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: color),
        ),
        Text(etiqueta,
            style: const TextStyle(fontSize: 11, color: Colors.grey)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final manzana2262 =
        _domicilios.where((d) => d['manzana'] == '2262').toList();
    final manzana2261 =
        _domicilios.where((d) => d['manzana'] == '2261').toList();

    final totalExcedidos = _domicilios.where((d) {
      return _espaciosOcupados(d['vehiculos'] as List) >
          espaciosPorDomicilio;
    }).length;

    final totalLibres = _domicilios.where((d) {
      return _espaciosOcupados(d['vehiculos'] as List) == 0;
    }).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Espacios de Parqueo'),
      ),
      body: Column(
        children: [
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
                _contadorEspacio('Domicilios',
                    '${_domicilios.length}', Icons.home, Colors.white),
                _contadorEspacio(
                    'Libres', '$totalLibres', Icons.check_circle, TemaFragata.dorado),
                _contadorEspacio('Excedidos', '$totalExcedidos',
                    Icons.warning_amber, TemaFragata.rojoPendiente),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: [
                _encabezadoManzana('Manzana 2262'),
                ...manzana2262.asMap().entries.map(
                      (e) => _tarjetaDomicilio(context, e.value,
                          _domicilios.indexOf(e.value)),
                    ),
                const SizedBox(height: 16),
                _encabezadoManzana('Manzana 2261'),
                ...manzana2261.asMap().entries.map(
                      (e) => _tarjetaDomicilio(context, e.value,
                          _domicilios.indexOf(e.value)),
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

  Widget _tarjetaDomicilio(
      BuildContext context, Map<String, dynamic> domicilio, int indice) {
    final vehiculos = domicilio['vehiculos'] as List<Map<String, dynamic>>;
    final ocupados = _espaciosOcupados(vehiculos);
    final estado = _estadoEspacio(ocupados);

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
            domicilio['id'],
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          'Familia ${domicilio['familia']}',
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        subtitle: Text(
          '${vehiculos.length} vehículo(s) — ${vehiculos.where((v) => v['tipo'] == 'auto').length} auto(s), ${vehiculos.where((v) => v['tipo'] == 'moto').length} moto(s)',
          style: const TextStyle(fontSize: 12),
        ),
        trailing: Chip(
          label: Text(
            estado,
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
          backgroundColor: _colorEstado(estado),
          padding: EdgeInsets.zero,
        ),
        onTap: () => _mostrarDetalle(context, indice),
      ),
    );
  }
}