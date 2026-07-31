import '../../domain/entities/memory_location.dart';
import '../../domain/repositories/memory_map_repository.dart';
import '../datasource/mock_memory_datasource.dart';

class MemoryMapRepositoryImpl implements MemoryMapRepository {
  final MockMemoryDatasource datasource;

  MemoryMapRepositoryImpl(this.datasource);

  @override
  Future<List<MemoryLocation>> getMemories() async {
    try {
      final models = await datasource.getMockMemories();
      return models;
    } catch (e) {
      throw Exception('Failed to load memories: $e');
    }
  }
}
