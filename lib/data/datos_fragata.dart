class DatosFragata {
  static const String nombreCiudadela = 'Ciudadela La Fragata';
  static const String administrador   = 'Carlos Vicente Medina Alvarado';
  static const double montoAlicuota  = 10.00;
  static const String mesActual      = 'Mayo 2026';
  static const int totalFamilias     = 24;

  static final List<Map<String, String>> historialPagos = [
    {'mes': 'Enero 2026',     'estado': 'Pagado'},
    {'mes': 'Febrero 2026',   'estado': 'Pagado'},
    {'mes': 'Marzo 2026',     'estado': 'Pagado'},
    {'mes': 'Abril 2026',     'estado': 'Pagado'},
    {'mes': 'Mayo 2026',      'estado': 'Pendiente'},
    {'mes': 'Junio 2026',     'estado': 'Pendiente'},
    {'mes': 'Julio 2026',     'estado': 'Pendiente'},
    {'mes': 'Agosto 2026',    'estado': 'Pendiente'},
    {'mes': 'Septiembre 2026','estado': 'Pendiente'},
    {'mes': 'Octubre 2026',   'estado': 'Pendiente'},
    {'mes': 'Noviembre 2026', 'estado': 'Pendiente'},
    {'mes': 'Diciembre 2026', 'estado': 'Pendiente'},
  ];

  static final List<Map<String, String>> familias = [
    // Manzana 2262
    {'id':'01','apellido':'Medina Alvarado',   'manzana':'2262','estado':'Pagado'},
    {'id':'02','apellido':'Guerrero Ponce',    'manzana':'2262','estado':'Pagado'},
    {'id':'03','apellido':'Salazar Intriago',  'manzana':'2262','estado':'Pagado'},
    {'id':'04','apellido':'Chávez Moran',      'manzana':'2262','estado':'Vencido'},
    {'id':'05','apellido':'Pincay Navarrete',  'manzana':'2262','estado':'Pagado'},
    {'id':'06','apellido':'Burgos Lozano',     'manzana':'2262','estado':'Pendiente'},
    {'id':'07','apellido':'Reyes Villacís',    'manzana':'2262','estado':'Pagado'},
    {'id':'08','apellido':'Cárdenas Mora',     'manzana':'2262','estado':'Pendiente'},
    {'id':'09','apellido':'Zambrano Olvera',   'manzana':'2262','estado':'Pagado'},
    {'id':'10','apellido':'Loor Mendoza',      'manzana':'2262','estado':'Vencido'},
    {'id':'11','apellido':'Andrade Cedeño',    'manzana':'2262','estado':'Pagado'},
    {'id':'12','apellido':'Freire Espinoza',   'manzana':'2262','estado':'Pendiente'},
    // Manzana 2261
    {'id':'13','apellido':'Vélez Santana',     'manzana':'2261','estado':'Pagado'},
    {'id':'14','apellido':'Muñoz Delgado',     'manzana':'2261','estado':'Pagado'},
    {'id':'15','apellido':'Tobar Almeida',     'manzana':'2261','estado':'Vencido'},
    {'id':'16','apellido':'Quiñónez Palma',    'manzana':'2261','estado':'Pagado'},
    {'id':'17','apellido':'Suárez Hidalgo',    'manzana':'2261','estado':'Pendiente'},
    {'id':'18','apellido':'Montoya Rivas',     'manzana':'2261','estado':'Pagado'},
    {'id':'19','apellido':'Peñafiel Castro',   'manzana':'2261','estado':'Pagado'},
    {'id':'20','apellido':'Ormaza Briones',    'manzana':'2261','estado':'Vencido'},
    {'id':'21','apellido':'Gallardo Pilco',    'manzana':'2261','estado':'Pagado'},
    {'id':'22','apellido':'Bone Macías',       'manzana':'2261','estado':'Pendiente'},
    {'id':'23','apellido':'Intriago Figueroa', 'manzana':'2261','estado':'Pagado'},
    {'id':'24','apellido':'Rosado Cevallos',   'manzana':'2261','estado':'Pendiente'},
  ];

static final List<Map<String, dynamic>> domicilios = [
  // Manzana 2262
  {
    'id': '01', 'familia': 'Medina Alvarado', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-1234', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-5678', 'tipo': 'auto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '02', 'familia': 'Guerrero Ponce', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-2341', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-8821', 'tipo': 'moto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-9012', 'tipo': 'moto', 'titular': 'Arrendatario'},
    ]
  },
  {
    'id': '03', 'familia': 'Salazar Intriago', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-3456', 'tipo': 'moto', 'titular': 'Propietario'},
      {'placa': 'GYE-3457', 'tipo': 'moto', 'titular': 'Propietario'},
      {'placa': 'GYE-3458', 'tipo': 'moto', 'titular': 'Arrendatario'},
    ]
  },
  {
    'id': '04', 'familia': 'Chávez Moran', 'manzana': '2262',
    'vehiculos': [] // Sin vehículos
  },
  {
    'id': '05', 'familia': 'Pincay Navarrete', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-5001', 'tipo': 'auto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '06', 'familia': 'Burgos Lozano', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-6001', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-6002', 'tipo': 'auto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-6003', 'tipo': 'auto', 'titular': 'Arrendatario'}, // Excedido
    ]
  },
  {
    'id': '07', 'familia': 'Reyes Villacís', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-7001', 'tipo': 'moto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '08', 'familia': 'Cárdenas Mora', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-8001', 'tipo': 'auto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-8002', 'tipo': 'moto', 'titular': 'Arrendatario'},
    ]
  },
  {
    'id': '09', 'familia': 'Zambrano Olvera', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-9001', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-9002', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-9003', 'tipo': 'moto', 'titular': 'Arrendatario'}, // Excedido
    ]
  },
  {
    'id': '10', 'familia': 'Loor Mendoza', 'manzana': '2262',
    'vehiculos': [] // Sin vehículos
  },
  {
    'id': '11', 'familia': 'Andrade Cedeño', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-1101', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-1102', 'tipo': 'moto', 'titular': 'Propietario'},
      {'placa': 'GYE-1103', 'tipo': 'moto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '12', 'familia': 'Freire Espinoza', 'manzana': '2262',
    'vehiculos': [
      {'placa': 'GYE-1201', 'tipo': 'moto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-1202', 'tipo': 'moto', 'titular': 'Arrendatario'},
    ]
  },
  // Manzana 2261
  {
    'id': '13', 'familia': 'Vélez Santana', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-1301', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-1302', 'tipo': 'auto', 'titular': 'Arrendatario'},
    ]
  },
  {
    'id': '14', 'familia': 'Muñoz Delgado', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-1401', 'tipo': 'auto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '15', 'familia': 'Tobar Almeida', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-1501', 'tipo': 'moto', 'titular': 'Propietario'},
      {'placa': 'GYE-1502', 'tipo': 'moto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-1503', 'tipo': 'moto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-1504', 'tipo': 'moto', 'titular': 'Arrendatario'}, // Excedido
    ]
  },
  {
    'id': '16', 'familia': 'Quiñónez Palma', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-1601', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-1602', 'tipo': 'moto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '17', 'familia': 'Suárez Hidalgo', 'manzana': '2261',
    'vehiculos': [] // Sin vehículos
  },
  {
    'id': '18', 'familia': 'Montoya Rivas', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-1801', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-1802', 'tipo': 'auto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '19', 'familia': 'Peñafiel Castro', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-1901', 'tipo': 'auto', 'titular': 'Arrendatario'},
    ]
  },
  {
    'id': '20', 'familia': 'Ormaza Briones', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-2001', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-2002', 'tipo': 'moto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-2003', 'tipo': 'moto', 'titular': 'Arrendatario'},
      {'placa': 'GYE-2004', 'tipo': 'moto', 'titular': 'Arrendatario'}, // Excedido
    ]
  },
  {
    'id': '21', 'familia': 'Gallardo Pilco', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-2101', 'tipo': 'moto', 'titular': 'Propietario'},
      {'placa': 'GYE-2102', 'tipo': 'moto', 'titular': 'Propietario'},
      {'placa': 'GYE-2103', 'tipo': 'moto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '22', 'familia': 'Bone Macías', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-2201', 'tipo': 'auto', 'titular': 'Propietario'},
    ]
  },
  {
    'id': '23', 'familia': 'Intriago Figueroa', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-2301', 'tipo': 'auto', 'titular': 'Propietario'},
      {'placa': 'GYE-2302', 'tipo': 'auto', 'titular': 'Arrendatario'},
    ]
  },
  {
    'id': '24', 'familia': 'Rosado Cevallos', 'manzana': '2261',
    'vehiculos': [
      {'placa': 'GYE-2401', 'tipo': 'moto', 'titular': 'Arrendatario'},
    ]
  },
];
}