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
}