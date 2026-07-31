import '../entities/memory_location.dart';
import '../repositories/memory_map_repository.dart';

class GetMemoryLocationsUseCase {
  final MemoryMapRepository repository;

  GetMemoryLocationsUseCase(this.repository);

  Future<List<MemoryLocation>> execute() async {
    return await repository.getMemories();
  }
}
