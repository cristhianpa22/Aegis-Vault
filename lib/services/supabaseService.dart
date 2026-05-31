import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/safehouse.dart';



class SupabaseService {
  SupabaseService._();

      
  static  String get supabaseUrl => dotenv.env['supabaseUrl']!;
  static  String get apiKey => dotenv.env['apiKey']!;

  static const String _safehousesTable = 'safehouses';

  static SupabaseClient get client => Supabase.instance.client;

  static Future<void> initialize() async {
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: apiKey,
    );
  }

  static Future<List<Safehouse>> getSafehouses() async {
    final response = await client.from(_safehousesTable).select();

    return (response as List)
        .map((item) => Safehouse.fromJson(item as Map<String, dynamic>))
        .toList();
  }

  static Future<Safehouse?> getSafehouseById(String id) async {
    final response = await client
        .from(_safehousesTable)
        .select()
        .eq('id', id)
        .maybeSingle();

    if (response == null) return null;
    return Safehouse.fromJson(response);
  }

  

  

  
}
