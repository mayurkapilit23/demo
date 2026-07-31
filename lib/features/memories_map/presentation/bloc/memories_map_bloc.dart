import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_memory_locations_usecase.dart';
import 'memories_map_event.dart';
import 'memories_map_state.dart';

class MemoriesMapBloc extends Bloc<MemoriesMapEvent, MemoriesMapState> {
  final GetMemoryLocationsUseCase getMemoryLocationsUseCase;

  MemoriesMapBloc(this.getMemoryLocationsUseCase) : super(MemoriesMapInitial()) {
    on<LoadMemoriesMap>(_onLoadMemoriesMap);
  }

  Future<void> _onLoadMemoriesMap(
    LoadMemoriesMap event,
    Emitter<MemoriesMapState> emit,
  ) async {
    emit(MemoriesMapLoading());
    try {
      final memories = await getMemoryLocationsUseCase.execute();
      if (memories.isEmpty) {
        emit(const MemoriesMapLoaded([]));
      } else {
        emit(MemoriesMapLoaded(memories));
      }
    } catch (e) {
      emit(MemoriesMapError(e.toString()));
    }
  }
}
