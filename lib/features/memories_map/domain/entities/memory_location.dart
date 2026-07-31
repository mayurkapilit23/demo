import 'package:equatable/equatable.dart';

class MemoryLocation extends Equatable {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final double latitude;
  final double longitude;
  final DateTime createdAt;

  const MemoryLocation({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        imageUrl,
        latitude,
        longitude,
        createdAt,
      ];
}
