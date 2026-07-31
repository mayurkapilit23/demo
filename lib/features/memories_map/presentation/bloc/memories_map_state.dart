import 'package:equatable/equatable.dart';
import '../../domain/entities/memory_location.dart';

abstract class MemoriesMapState extends Equatable {
  const MemoriesMapState();

  @override
  List<Object> get props => [];
}

class MemoriesMapInitial extends MemoriesMapState {}

class MemoriesMapLoading extends MemoriesMapState {}

class MemoriesMapLoaded extends MemoriesMapState {
  final List<MemoryLocation> memories;

  const MemoriesMapLoaded(this.memories);

  @override
  List<Object> get props => [memories];
}

class MemoriesMapError extends MemoriesMapState {
  final String message;

  const MemoriesMapError(this.message);

  @override
  List<Object> get props => [message];
}
