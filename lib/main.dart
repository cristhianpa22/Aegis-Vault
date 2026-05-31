import 'package:flutter/material.dart';

import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'services/supabaseService.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: 'lib/.env');

  await SupabaseService.initialize();
  try{
    final safehouses = await SupabaseService.getSafehouses();
    print('Conexion OK: ${safehouses.length} registros');
  }catch(e){
    print('Error Supabase: ${e}');
  }
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      ),
    );
  }
}



