import '../../domain/entities/memory_location.dart';

class MemoryLocationModel extends MemoryLocation {
  const MemoryLocationModel({
    required super.id,
    required super.title,
    required super.description,
    required super.imageUrl,
    required super.latitude,
    required super.longitude,
    required super.createdAt,
  });

  factory MemoryLocationModel.fromJson(Map<String, dynamic> json) {
    return MemoryLocationModel(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      createdAt: DateTime.parse(json['createdAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'latitude': latitude,
      'longitude': longitude,
      'createdAt': createdAt.toIso8601String(),
    };
  }
}
