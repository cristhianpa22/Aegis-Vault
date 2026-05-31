class Safehouse {
  const Safehouse({
    required this.id,
    required this.codename,
    required this.sector,
    required this.latitude,
    required this.longitude,
    this.capacity = 5,
    this.isCompromised = false,
    this.createdAt,
  });

  final String id;
  final String codename;
  final String sector;
  final double latitude;
  final double longitude;
  final int capacity;
  final bool isCompromised;
  final DateTime? createdAt;

  factory Safehouse.fromJson(Map<String, dynamic> json) {
    return Safehouse(
      id: json['id'] as String,
      codename: json['codename'] as String,
      sector: json['sector'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      capacity: json['capacity'] as int? ?? 5,
      isCompromised: json['is_compromised'] as bool? ?? false,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codename': codename,
      'sector': sector,
      'latitude': latitude,
      'longitude': longitude,
      'capacity': capacity,
      'is_compromised': isCompromised,
      if (createdAt != null) 'created_at': createdAt!.toIso8601String(),
    };
  }

}
