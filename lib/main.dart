import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'models/safehouse.dart';
import 'screens/safehouse_screen.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/supabaseService.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'lib/.env');

  await SupabaseService.initialize();
<<<<<<< 
  try{
    final safehouses = await SupabaseService.getSafehouses();
    print('Conexion OK: ${safehouses.length} registros');
  }catch(e){
    print('Error Supabase: $e');
=======

  List<Safehouse> safehousesCargados = [];

  try {
    safehousesCargados = await SupabaseService.getSafehouses();
    print('Conexion OK: ${safehousesCargados.length} registros');
  } catch (e) {
    print('Error Supabase: ${e}');
>>>>>>> main
  }
  runApp(MyApp(safehouses: safehousesCargados));
}

class MyApp extends StatelessWidget {
  final List<Safehouse> safehouses;
  const MyApp({super.key, required this.safehouses});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF080A0F), // Fondo negro profundo
        cardColor: const Color(0xFF121824), // Fondo de tarjeta táctica
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFCC),       // Cian Neón
          secondary: Color(0xFF9D4EDD),     // Morado Eléctrico
          error: Color(0xFFFF0055),         // Rosa/Rojo Neón
          errorContainer: Color(0xFF2A0815),// Fondo de alerta oscuro
          onErrorContainer: Color(0xFFFFB3C1),
        ),
        textTheme: GoogleFonts.shareTechMonoTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: SafehouseScreen(safehouses: safehouses),
    );
  }
}


