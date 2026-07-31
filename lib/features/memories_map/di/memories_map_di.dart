import 'package:get_it/get_it.dart';
import '../data/datasource/mock_memory_datasource.dart';
import '../data/repositories/memory_map_repository_impl.dart';
import '../domain/repositories/memory_map_repository.dart';
import '../domain/usecases/get_memory_locations_usecase.dart';
import '../presentation/bloc/memories_map_bloc.dart';

final sl = GetIt.instance;

Future<void> initMemoriesMapDi() async {
  // Bloc
  sl.registerFactory(() => MemoriesMapBloc(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetMemoryLocationsUseCase(sl()));

  // Repository
  sl.registerLazySingleton<MemoryMapRepository>(
    () => MemoryMapRepositoryImpl(sl()),
  );

  // Data sources
  sl.registerLazySingleton<MockMemoryDatasource>(
    () => MockMemoryDatasourceImpl(),
  );
}
