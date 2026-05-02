import 'package:flutter/material.dart';
import 'package:la_fragata_app/data/datos_fragata.dart';
import 'package:la_fragata_app/routes/rutas_fragata.dart';
import 'package:la_fragata_app/theme/tema_fragata.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/gestures.dart';

class PantallaInicio extends StatefulWidget {
  const PantallaInicio({super.key});

  @override
  State<PantallaInicio> createState() => _PantallaInicioState();
}

class _PantallaInicioState extends State<PantallaInicio> {
  final PageController _controladorCarrusel = PageController();
  int _paginaActual = 0;

  final List<Map<String, dynamic>> _noticias = [
    {
      'titulo': 'Mantenimiento de Portón',
      'descripcion': 'El sábado 10 de mayo se realizará mantenimiento del motor.',
      'icono': Icons.build,
      'color': TemaFragata.azulMedio,
    },
    {
      'titulo': 'Recordatorio de Pago',
      'descripcion': 'La alícuota de Mayo vence el 15 de mayo. ¡Paga a tiempo!',
      'icono': Icons.receipt_long,
      'color': TemaFragata.naranjaVencido,
    },
    {
      'titulo': 'Reunión de Vecinos',
      'descripcion': 'Reunión el viernes 16 de mayo a las 19h00 en la cuadra.',
      'icono': Icons.people,
      'color': TemaFragata.verdePagado,
    },
    {
      'titulo': 'Normas de Seguridad',
      'descripcion': 'Recuerda no prestar tu acceso a personas externas.',
      'icono': Icons.security,
      'color': TemaFragata.rojoPendiente,
    },
  ];

 final List<Map<String, dynamic>> _espacios = [
  {
    'nombre': 'Espacios de Parqueo',
    'descripcion': 'Ver y gestionar vehículos por domicilio',
    'icono': Icons.local_parking,
    'disponible': true,
  },
];
  void _mostrarReserva(BuildContext context, Map<String, dynamic> espacio) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: Row(
          children: [
            Icon(espacio['icono'], color: TemaFragata.azulMarino),
            const SizedBox(width: 8),
            Expanded(child: Text(espacio['nombre'])),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(espacio['descripcion']),
            const SizedBox(height: 12),
            Row(
              children: [
                const Text('Estado: '),
                Chip(
                  label: Text(
                    espacio['disponible'] ? 'Disponible' : 'Ocupado',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                  backgroundColor: espacio['disponible']
                      ? TemaFragata.verdePagado
                      : TemaFragata.rojoPendiente,
                  padding: EdgeInsets.zero,
                ),
              ],
            ),
            if (!espacio['disponible'])
              const Padding(
                padding: EdgeInsets.only(top: 8),
                child: Text(
                  'Este espacio no está disponible en este momento.',
                  style: TextStyle(
                    color: TemaFragata.rojoPendiente,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          if (espacio['disponible'])
            ElevatedButton(
              onPressed: () {
                Navigator.pop(ctx);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '✅ Reserva confirmada: ${espacio['nombre']}',
                    ),
                    backgroundColor: TemaFragata.verdePagado,
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Confirmar Reserva'),
            ),
        ],
      ),
    );
  }

  void _mostrarPago(BuildContext context) {
  String? _nombreArchivo;

  showDialog(
    context: context,
    builder: (ctx) => StatefulBuilder(
      builder: (context, setStateDialog) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Row(
          children: [
            Icon(Icons.payment, color: TemaFragata.azulMarino),
            SizedBox(width: 8),
            Text('Pagar Alícuota'),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: TemaFragata.azulMarino.withOpacity(0.05),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  _filaDetalle('Mes:', DatosFragata.mesActual),
                  _filaDetalle(
                    'Valor:',
                    '\$${DatosFragata.montoAlicuota.toStringAsFixed(2)}',
                  ),
                  _filaDetalle('Ciudadela:', DatosFragata.nombreCiudadela),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Sube tu comprobante de pago:',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: TemaFragata.azulMarino,
                ),
              ),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () async {
                final resultado = await FilePicker.platform.pickFiles(
                  type: FileType.custom,
                  allowedExtensions: ['jpg', 'jpeg', 'png'],
                );
                if (resultado != null) {
                  setStateDialog(() {
                    _nombreArchivo = resultado.files.single.name;
                  });
                }
              },
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: _nombreArchivo != null
                        ? TemaFragata.verdePagado
                        : TemaFragata.azulMedio,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                  color: _nombreArchivo != null
                      ? TemaFragata.verdePagado.withOpacity(0.05)
                      : TemaFragata.azulMedio.withOpacity(0.05),
                ),
                child: Column(
                  children: [
                    Icon(
                      _nombreArchivo != null
                          ? Icons.check_circle
                          : Icons.upload_file,
                      color: _nombreArchivo != null
                          ? TemaFragata.verdePagado
                          : TemaFragata.azulMedio,
                      size: 36,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      _nombreArchivo ?? 'Toca para seleccionar\nJPG o PNG',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: _nombreArchivo != null
                            ? TemaFragata.verdePagado
                            : Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: _nombreArchivo == null
                ? null
                : () {
                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          '✅ Comprobante enviado — se espera confirmación del administrador',
                        ),
                        backgroundColor: TemaFragata.verdePagado,
                        duration: const Duration(seconds: 3),
                      ),
                    );
                  },
            child: const Text('Enviar Comprobante'),
          ),
        ],
      ),
    ),
  );
}

  Widget _filaDetalle(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(etiqueta, style: const TextStyle(color: Colors.grey)),
          Text(
            valor,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controladorCarrusel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pendientes = DatosFragata.historialPagos
        .where((p) => p['estado'] != 'Pagado')
        .length;

    return Scaffold(
      // ── DRAWER ──────────────────────────────────────────
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              decoration: const BoxDecoration(
                color: TemaFragata.azulMarino,
              ),
              accountName: const Text(
                DatosFragata.administrador,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text(DatosFragata.nombreCiudadela),
              currentAccountPicture: const CircleAvatar(
                backgroundColor: TemaFragata.dorado,
                child: Icon(
                  Icons.person,
                  color: TemaFragata.azulMarino,
                  size: 36,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home, color: TemaFragata.azulMarino),
              title: const Text('Inicio'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.sensor_door,
                  color: TemaFragata.azulMarino),
              title: const Text('Control de Portón'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'porton');
              },
            ),
            ListTile(
              leading: const Icon(Icons.receipt_long,
                  color: TemaFragata.azulMarino),
              title: const Text('Mi Alícuota'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'alicuota');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.people, color: TemaFragata.azulMarino),
              title: const Text('Familias Residentes'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'familias');
              },
            ),
            ListTile(
              leading: const Icon(Icons.local_parking,
                  color: TemaFragata.azulMarino),
              title: const Text('Espacios de Parqueo'),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, 'espacios');
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.info_outline,
                  color: TemaFragata.azulMedio),
              title: const Text('Versión 1.0.0'),
              subtitle: const Text('La Fragata App'),
            ),
          ],
        ),
      ),

      // ── APPBAR ──────────────────────────────────────────
      appBar: AppBar(
        title: const Text('La Fragata App'),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Chip(
              avatar: const Icon(
                Icons.calendar_month,
                color: TemaFragata.azulMarino,
                size: 16,
              ),
              label: Text(
                DatosFragata.mesActual,
                style: const TextStyle(
                  color: TemaFragata.azulMarino,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              backgroundColor: TemaFragata.dorado,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),

      // ── BODY ────────────────────────────────────────────
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Tarjeta de usuario
          Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundColor: TemaFragata.azulMarino,
                    child: Icon(
                      Icons.person,
                      color: TemaFragata.dorado,
                      size: 32,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          DatosFragata.administrador,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: TemaFragata.azulMarino,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          DatosFragata.nombreCiudadela,
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 6),
                        const Chip(
                          label: Text(
                            'Administrador',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                            ),
                          ),
                          backgroundColor: TemaFragata.azulMedio,
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Tarjeta alícuota pendiente
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Alícuotas Pendientes',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: TemaFragata.azulMarino,
                          fontSize: 15,
                        ),
                      ),
                      Chip(
                        label: Text(
                          '$pendientes meses',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                        backgroundColor: pendientes > 0
                            ? TemaFragata.rojoPendiente
                            : TemaFragata.verdePagado,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    pendientes > 0
                        ? 'Tienes $pendientes meses por pagar — \$${(pendientes * DatosFragata.montoAlicuota).toStringAsFixed(2)} pendiente'
                        : '¡Estás al día con todos tus pagos!',
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => _mostrarPago(context),
                      icon: const Icon(Icons.payment),
                      label: const Text('Pagar Aquí'),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Carrusel de noticias
          const Text(
            'Noticias y Avisos',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: TemaFragata.azulMarino,
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 140,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controladorCarrusel,
                  itemCount: _noticias.length,
                  onPageChanged: (indice) =>
                      setState(() => _paginaActual = indice),
                  itemBuilder: (context, indice) {
                    final noticia = _noticias[indice];
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 32),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: (noticia['color'] as Color).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: (noticia['color'] as Color).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: noticia['color'],
                            radius: 28,
                            child: Icon(
                              noticia['icono'],
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  noticia['titulo'],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: noticia['color'],
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  noticia['descripcion'],
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
      // Flecha izquierda
      Positioned(
        left: 0,
        top: 0,
        bottom: 0,
        child: Center(
          child: IconButton(
            onPressed: _paginaActual > 0
                ? () => _controladorCarrusel.previousPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                : null,
            icon: Icon(
              Icons.arrow_back_ios,
              color: _paginaActual > 0
                  ? TemaFragata.azulMarino
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ),
      // Flecha derecha
      Positioned(
        right: 0,
        top: 0,
        bottom: 0,
        child: Center(
          child: IconButton(
            onPressed: _paginaActual < _noticias.length - 1
                ? () => _controladorCarrusel.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    )
                : null,
            icon: Icon(
              Icons.arrow_forward_ios,
              color: _paginaActual < _noticias.length - 1
                  ? TemaFragata.azulMarino
                  : Colors.grey.shade300,
            ),
          ),
        ),
      ),
    ],
  ),
),
          // Indicadores del carrusel
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              _noticias.length,
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                margin: const EdgeInsets.symmetric(horizontal: 3),
                width: _paginaActual == i ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _paginaActual == i
                      ? TemaFragata.azulMarino
                      : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Reservas de espacios
          const Text(
            'Espacios Comunes',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: TemaFragata.azulMarino,
            ),
          ),
          const SizedBox(height: 8),
          ..._espacios.map(
            (espacio) => Card(
              elevation: 2,
              margin: const EdgeInsets.only(bottom: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: espacio['disponible']
                      ? TemaFragata.verdePagado
                      : TemaFragata.rojoPendiente,
                  child: Icon(
                    espacio['icono'],
                    color: Colors.white,
                  ),
                ),
                title: Text(
                  espacio['nombre'],
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(espacio['descripcion']),
                trailing: Chip(
                  label: Text(
                    espacio['disponible'] ? 'Disponible' : 'Ocupado',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                    ),
                  ),
                  backgroundColor: espacio['disponible']
                      ? TemaFragata.verdePagado
                      : TemaFragata.rojoPendiente,
                  padding: EdgeInsets.zero,
                ),
                onTap: () => Navigator.pushNamed(context, 'espacios'),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // Información y Seguridad
          const Text(
            'Información y Seguridad',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: TemaFragata.azulMarino,
            ),
          ),
          const SizedBox(height: 8),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                ExpansionTile(
                  leading: const Icon(
                    Icons.info_outline,
                    color: TemaFragata.azulMedio,
                  ),
                  title: const Text('Información General'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _filaInfo('Ciudadela:', DatosFragata.nombreCiudadela),
                          _filaInfo('Manzanas:', '2261 y 2262'),
                          _filaInfo('Familias:', '${DatosFragata.totalFamilias}'),
                          _filaInfo('Alícuota mensual:',
                              '\$${DatosFragata.montoAlicuota.toStringAsFixed(2)}'),
                          _filaInfo('Administrador:', DatosFragata.administrador),
                        ],
                      ),
                    ),
                  ],
                ),
                const Divider(height: 1),
                ExpansionTile(
                  leading: const Icon(
                    Icons.security,
                    color: TemaFragata.rojoPendiente,
                  ),
                  title: const Text('Normas de Seguridad'),
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          _ItemSeguridad(
                            '🔒 No compartir el acceso al portón con personas externas.',
                          ),
                          _ItemSeguridad(
                            '🚗 Respetar los espacios de parqueo asignados.',
                          ),
                          _ItemSeguridad(
                            '🧒 Los niños pueden jugar en la cuadra con supervisión.',
                          ),
                          _ItemSeguridad(
                            '📢 Reportar actividad sospechosa al administrador.',
                          ),
                          _ItemSeguridad(
                            '🕙 El portón se cierra automáticamente tras 60 segundos de inactividad.',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _filaInfo(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(etiqueta, style: const TextStyle(color: Colors.grey)),
          Text(valor,
              style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _ItemSeguridad extends StatelessWidget {
  final String texto;
  const _ItemSeguridad(this.texto);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Text(texto, style: const TextStyle(fontSize: 13)),
    );
  }
}