import 'package:flutter/material.dart';
import 'models/safehouse.dart';
import 'screens/safehouse_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'services/supabaseService.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'lib/.env');
  await SupabaseService.initialize();
  
  List<Safehouse> safehousesCargados = [];

  try {
    safehousesCargados = await SupabaseService.getSafehouses();
    print('Conexion OK: ${safehousesCargados.length} registros');
  } catch (e) {
    print('Error Supabase: ${e}');
  }

  runApp(MyApp(safehouses: safehousesCargados));
}

class MyApp extends StatelessWidget {
  final List<Safehouse> safehouses;

  const MyApp({super.key, required this.safehouses});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF080A0F),
        cardColor: const Color(0xFF121824),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FFCC),
          secondary: Color(0xFF9D4EDD),
          error: Color(0xFFFF0055),
          errorContainer: Color(0xFF2A0815),
          onErrorContainer: Color(0xFFFFB3C1),
        ),
        textTheme: GoogleFonts.shareTechMonoTextTheme(
          ThemeData.dark().textTheme,
        ),
      ),
      home: const SafehouseScreen(),
    );
  }
}