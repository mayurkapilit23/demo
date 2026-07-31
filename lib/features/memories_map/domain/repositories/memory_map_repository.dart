import '../entities/memory_location.dart';

abstract class MemoryMapRepository {
  Future<List<MemoryLocation>> getMemories();
}
