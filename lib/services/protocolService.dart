import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vibration/vibration.dart';

import 'package:aegis_vault/models/safehouse.dart';
import 'package:aegis_vault/services/supabaseService.dart';

class ProtocolService {
  final _storage = const FlutterSecureStorage();

  final latitud = 4.7068;
  final longitud = -74.210;

  Future<void> saveProtocols(List<Safehouse> safehouses) async {
    final List<Map<String, dynamic>> jsonList = safehouses
        .map((s) => s.toJson())
        .toList();
    final String protocolsJson = jsonEncode(jsonList);
    await _storage.write(key: 'cache_emergencia', value: protocolsJson);
  }

  Future<List<Safehouse>> getLocalCache() async {
    final data = await _storage.read(key: 'cache_emergencia');
    if (data != null) {
      final List<dynamic> decodedList = jsonDecode(data);
      return decodedList.map((json) => Safehouse.fromJson(json)).toList();
    } else {
      return [];
    }
  }

  Future<Map<String, dynamic>> getProtocolsFromSupabase() async {
    try {
      final data = await SupabaseService.getSafehouses();
      await saveProtocols(data);
      return {"data": data, "isOffline": false};
    } on SocketException catch (i) {
      debugPrint("Error de conexión a internet: $i");
      final localData = await getLocalCache();
      return {'data': localData, 'isOffline': true};
    } catch (e) {
      debugPrint("Error al obtener los protocolos: $e");
      return {'data': [], 'isOffline': true};
    }
  }

  void proximityCheck() {
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10,
      ),
    ).listen((Position position) async {
      double distance = Geolocator.distanceBetween(
        position.latitude,
        position.longitude,
        latitud,
        longitud,
      );

      if (distance <= 100) {
        if (await Vibration.hasVibrator() ?? false) {
          Vibration.vibrate(pattern: [0, 100, 200, 100], repeat: -1);
        }
      } else {
        Vibration.cancel();
      }
    });
  }
}